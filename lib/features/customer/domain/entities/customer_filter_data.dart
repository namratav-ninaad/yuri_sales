class CustomerFilterData {
  final String? search;
  final int? companyId;
  final bool? active;


  const CustomerFilterData({
    this.search,
    this.companyId,
    this.active,
  });

  Map<String, dynamic> toQuery() {
    return {
      if (search != null && search!.isNotEmpty) "search": search,
      if (companyId != null) "company_id": companyId,
      if (active != null) "active": active,
    };
  }
}
