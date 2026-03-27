import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<SendOTPEvent>((event, emit) async {
      emit(AuthLoading());
      
      final completer = Completer<void>();
      
      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: "+91${event.phoneNumber}",
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
            if (!completer.isCompleted) {
              add(const _EmitSuccessEvent());
              completer.complete();
            }
          },
          verificationFailed: (FirebaseAuthException e) {
            if (!completer.isCompleted) {
              add(_EmitErrorEvent(e.message ?? "Verification Failed"));
              completer.complete();
            }
          },
          codeSent: (String verId, int? resendToken) {
            if (!completer.isCompleted) {
              add(_EmitCodeSentEvent(verId));
              completer.complete();
            }
          },
          codeAutoRetrievalTimeout: (String verId) {},
        );
        
        await completer.future;
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<_EmitCodeSentEvent>((event, emit) => emit(AuthCodeSent(event.verificationId)));
    on<_EmitErrorEvent>((event, emit) => emit(AuthError(event.message)));
    on<_EmitSuccessEvent>((event, emit) => emit(AuthSuccess()));

    on<VerifyOTPEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: event.verificationId,
          smsCode: event.smsCode,
        );
        await _auth.signInWithCredential(credential);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthError("Invalid OTP. Please try again."));
      }
    });

    on<GoogleSignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn.instance.authenticate();
        if (googleUser == null) {
          emit(AuthInitial());
          return;
        }
        
        final GoogleSignInAuthentication googleAuth = googleUser.authentication;
        final authz = await googleUser.authorizationClient.authorizeScopes([]);

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: authz.accessToken,
          idToken: googleAuth.idToken,
        );

        await _auth.signInWithCredential(credential);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthError("Google Sign-In failed: ${e.toString()}"));
      }
    });
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
