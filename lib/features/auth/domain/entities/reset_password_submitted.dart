class ResetPasswordData {
  final String email;
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordData({
    required this.email,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };
  }
}
