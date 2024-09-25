import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpProvider extends StateNotifier<String> {
  OtpProvider() : super('');

  void setOtp(String otp) {
    state = otp;
  }
}

final otpProvider = StateNotifierProvider<OtpProvider, String>((ref) {
  return OtpProvider();
});
