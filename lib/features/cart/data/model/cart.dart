import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class CartModel {
  @JsonKey(name: 'cart_id')
  final num? cartId;

  @JsonKey(name: 'cart_name')
  final String? cartName;

  @JsonKey(name: 'total_items')
  final num totalItems;

  @JsonKey(name: 'amount_untaxed')
  final num amountUntaxed;

  @JsonKey(name: 'amount_tax')
  final num amountTax;

  @JsonKey(name: 'amount_total')
  final num amountTotal;

  final String currency;

  @JsonKey(name: 'lines')
  final List<CartItem> cartProducts;

  CartModel({
    this.cartId,
    this.cartName,
    required this.totalItems,
    required this.amountUntaxed,
    required this.amountTax,
    required this.amountTotal,
    required this.currency,
    required this.cartProducts,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}

@JsonSerializable()
class CartItem {
  @JsonKey(name: 'line_id')
  final num lineId;

  @JsonKey(name: 'product_id')
  final num productId;

  @JsonKey(name: 'product_name')
  final String productName;

  @JsonKey(name: 'product_image')
  final String productImage;

  final num qty;
  final num price;
  final num subtotal;

  CartItem({
    required this.lineId,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.qty,
    required this.price,
    required this.subtotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
