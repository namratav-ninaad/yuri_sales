import 'dart:convert';
import 'dart:io';

class UpdateProfileData {
  final String fullName;
  final String companyId;
  final String email;
  final String mobileNumber;
  final String? profileImage;
  UpdateProfileData({
    required this.fullName,
    required this.companyId,
    required this.email,
    required this.mobileNumber,
    this.profileImage,
  });

  Future<Map<String, dynamic>> toMap() async {
    String? base64Image;

    if (profileImage != null && profileImage!.isNotEmpty) {
      final bytes = await File(profileImage!).readAsBytes();
      base64Image = base64Encode(bytes);
    }

    return {
      "full_name": fullName,
      "company_id": companyId,
      "email": email,
      "mobile": mobileNumber,
      "profile_photo": base64Image,
    };
  }
}