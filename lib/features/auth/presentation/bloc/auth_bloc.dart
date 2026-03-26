import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<SendOTPEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: "+91${event.phoneNumber}",
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            addError(e); // Optional: for logging
            emit(AuthError(e.message ?? "Verification Failed"));
          },
          codeSent: (String verId, int? resendToken) {
            emit(AuthCodeSent(verId));
          },
          codeAutoRetrievalTimeout: (String verId) {},
        );
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // 2. Handle OTP Verification
    on<VerifyOTPEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: event.verificationId,
          smsCode: event.smsCode,
        );
        // Sign the user in with the credential
        await _auth.signInWithCredential(credential);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthError("Invalid OTP. Please try again."));
      }
    });
  }
}