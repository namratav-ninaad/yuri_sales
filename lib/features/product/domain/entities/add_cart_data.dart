class AddCartData {
  final int productId;
  // final int qty;

  AddCartData({
    required this.productId,
    // required this.qty,
  });

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      // 'qty': qty,
    };
  }
}