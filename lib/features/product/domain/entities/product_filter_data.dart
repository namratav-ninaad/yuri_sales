class ProductFilterData {
  final String? name;

  const ProductFilterData({this.name});

  Map<String, dynamic> toQuery() {
    return {if (name != null && name!.isNotEmpty) "name": name};
  }
}
