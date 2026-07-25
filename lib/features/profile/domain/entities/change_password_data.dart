class ChangePasswordData {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordData({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  // Convert to Map for API request
  Map<String, dynamic> toMap() {
    return {
      'current_password': oldPassword,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };
  }
}
