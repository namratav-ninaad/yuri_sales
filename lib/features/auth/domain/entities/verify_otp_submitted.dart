class VerifyOtpData {
  final String email;
  final String otp;

  const VerifyOtpData({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'otp': otp,
    };
  }
}