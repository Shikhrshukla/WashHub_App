import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription? _googleSignInSubscription;

  AuthBloc() : super(AuthInitial()) {
    _googleSignInSubscription = GoogleSignIn.instance.authenticationEvents.listen((event) {
      if (event is GoogleSignInAuthenticationEventSignIn) {
        add(GoogleSignInWebSuccessEvent(event.user));
      }
    });

    on<SendOTPEvent>(_onSendOTP);
    on<VerifyOTPEvent>(_onVerifyOTP);
    on<GoogleSignInEvent>(_onGoogleSignIn);
    on<GoogleSignInWebSuccessEvent>(_onGoogleSignInWebSuccess);
    on<_EmitCodeSentEvent>((event, emit) => emit(AuthCodeSent(event.verificationId)));
    on<_EmitErrorEvent>((event, emit) => emit(AuthError(event.message)));
    on<_EmitSuccessEvent>((event, emit) => emit(AuthSuccess()));
  }

  Future<void> _onSendOTP(SendOTPEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91${event.phoneNumber}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          add(const _EmitSuccessEvent());
        },
        verificationFailed: (FirebaseAuthException e) {
          String msg = "Verification Failed";
          if (e.message?.contains("BILLING_NOT_ENABLED") ?? false) {
            msg = "Firebase Error: Disable 'reCAPTCHA Enterprise' in Firebase Console Settings.";
          } else {
            msg = e.message ?? e.code;
          }
          add(_EmitErrorEvent(msg));
        },
        codeSent: (String verId, int? resendToken) {
          add(_EmitCodeSentEvent(verId));
        },
        codeAutoRetrievalTimeout: (String verId) {},
      );
    } catch (e) {
      emit(AuthError("System Error: ${e.toString()}"));
    }
  }

  Future<void> _onVerifyOTP(VerifyOTPEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.smsCode,
      );
      await _auth.signInWithCredential(credential);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError("Invalid OTP code. Please try again."));
    }
  }

  Future<void> _onGoogleSignIn(GoogleSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Clear any previous session to force a fresh account picker
      await GoogleSignIn.instance.signOut();
      
      final GoogleSignInAccount? googleUser = await GoogleSignIn.instance.authenticate();
      if (googleUser == null) {
        emit(AuthInitial());
        return;
      }
      await _signInWithGoogle(googleUser);
      emit(AuthSuccess());
    } on GoogleSignInException catch (e) {
      debugPrint("Auth: Google Error Code -> ${e.code}");
      String msg = "Google Sign-In failed.";
      if (e.code == GoogleSignInExceptionCode.clientConfigurationError || 
          e.code == GoogleSignInExceptionCode.unknownError) {
        msg = "Developer Error: Ensure the SHA-1 in Firebase matches your debug key exactly. Try 'flutter clean'.";
      }
      emit(AuthError(msg));
    } catch (e) {
      emit(AuthError("Google Sign-In Error: $e"));
    }
  }

  Future<void> _onGoogleSignInWebSuccess(GoogleSignInWebSuccessEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _signInWithGoogle(event.user);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError("Google authentication failed."));
    }
  }

  Future<void> _signInWithGoogle(GoogleSignInAccount googleUser) async {
    // In 7.x, authentication is a getter
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    
    String? accessToken;
    try {
      // Explicitly fetch accessToken via authorizationClient
      final authz = await googleUser.authorizationClient.authorizeScopes([]);
      accessToken = authz.accessToken;
    } catch (e) {
      debugPrint("Auth: AccessToken fetch warning: $e");
    }

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: accessToken,
      idToken: googleAuth.idToken,
    );

    await _auth.signInWithCredential(credential);
  }

  @override
  Future<void> close() {
    _googleSignInSubscription?.cancel();
    return super.close();
  }
}

class _EmitCodeSentEvent extends AuthEvent {
  final String verificationId;
  const _EmitCodeSentEvent(this.verificationId);
}
class _EmitErrorEvent extends AuthEvent {
  final String message;
  const _EmitErrorEvent(this.message);
}
class _EmitSuccessEvent extends AuthEvent {
  const _EmitSuccessEvent();
}
