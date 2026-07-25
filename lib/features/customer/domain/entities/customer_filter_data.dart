class CustomerFilterData {
  final String? name;
  final int? companyId;
  final bool? active;

  const CustomerFilterData({
    this.name,
    this.companyId,
    this.active,
  });

  Map<String, dynamic> toQuery() {
    return {
      if (name != null && name!.isNotEmpty) "name": name,
      if (companyId != null) "company_id": companyId,
      if (active != null) "active": active,
    };
  }
}