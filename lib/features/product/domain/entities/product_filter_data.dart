class ProductFilterData {
  final String? name;
  final int? categoryId;

  const ProductFilterData({this.name, this.categoryId});

  Map<String, dynamic> toQuery() {
    return {
      if (name != null && name!.isNotEmpty) "name": name,
      'product_type': 'goods',
      'out_of_stock': false,
      'is_published': true,
      if (categoryId != null) "category_id": categoryId,
    };
  }
}