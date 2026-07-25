import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class CartModel {
  num cart_id;
  String cart_name;
  num total_items;
  num amount_untaxed;
  num amount_tax;
  num amount_total;
  String currency;
  List<CartItem> cartProducts;

  CartModel({
    required this.cart_id,
    required this.cart_name,
    required this.total_items,
    required this.amount_untaxed,
    required this.amount_tax,
    required this.amount_total,
    required this.currency,
    required this.cartProducts,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}

@JsonSerializable()
class CartItem {
  num line_id;
  num product_id;
  String product_name;
  String product_image;
  num qty;
  num price;
  num subtotal;

  CartItem({
    required this.product_image,
    required this.line_id,
    required this.product_id,
    required this.product_name,
    required this.qty,
    required this.price,
    required this.subtotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
