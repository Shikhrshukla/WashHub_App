import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SendOTPEvent extends AuthEvent {
  final String phoneNumber;
  const SendOTPEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyOTPEvent extends AuthEvent {
  final String verificationId;
  final String smsCode;
  const VerifyOTPEvent(this.verificationId, this.smsCode);

  @override
  List<Object?> get props => [verificationId, smsCode];
}

class GoogleSignInEvent extends AuthEvent {}

class GoogleSignInWebSuccessEvent extends AuthEvent {
  final GoogleSignInAccount user;
  const GoogleSignInWebSuccessEvent(this.user);

  @override
  List<Object?> get props => [user];
}
