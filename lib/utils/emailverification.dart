import 'package:email_otp/email_otp.dart';

class EmailVerification {
  void init() {
    EmailOTP.config(
      appName: 'MemeMates',
      otpType: OTPType.numeric,
      expiry: 30000,
      emailTheme: EmailTheme.v6,
      otpLength: 6,
    );
  }

  Future<bool> send(String email) async {
    return await EmailOTP.sendOTP(email: email);
  }

  Future<bool> verify(String otp) async {
    if (EmailOTP.isOtpExpired()) {
      return false;
    }
    return EmailOTP.verifyOTP(otp: otp);
  }
}
