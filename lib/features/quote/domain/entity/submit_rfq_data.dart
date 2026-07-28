class SubmitRfqData {
  final String name;
  final String email;
  final String phone;
  final String location;
  final String company;
  final int? companyId;
  final String notes;

  SubmitRfqData({
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.company,
    this.companyId,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "location": location,
      "company": company,
      if (companyId != null) "company_id": companyId,
      "notes": notes,
    };
  }
}
