import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];}

// User clicks "Continue"
class SendOTPEvent extends AuthEvent {
  final String phoneNumber;
  const SendOTPEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

// User enters the 6-digit code
class VerifyOTPEvent extends AuthEvent {
  final String verificationId;
  final String smsCode;
  const VerifyOTPEvent(this.verificationId, this.smsCode);

  @override
  List<Object?> get props => [verificationId, smsCode];
}