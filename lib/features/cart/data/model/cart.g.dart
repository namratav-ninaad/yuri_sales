// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
  cartId: json['cart_id'] as num?,
  cartName: json['cart_name'] as String?,
  totalItems: json['total_items'] as num,
  amountUntaxed: json['amount_untaxed'] as num,
  amountTax: json['amount_tax'] as num,
  amountTotal: json['amount_total'] as num,
  currency: json['currency'] as String,
  cartProducts: (json['lines'] as List<dynamic>)
      .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
  'cart_id': instance.cartId,
  'cart_name': instance.cartName,
  'total_items': instance.totalItems,
  'amount_untaxed': instance.amountUntaxed,
  'amount_tax': instance.amountTax,
  'amount_total': instance.amountTotal,
  'currency': instance.currency,
  'lines': instance.cartProducts,
};

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
  lineId: json['line_id'] as num,
  productId: json['product_id'] as num,
  productName: json['product_name'] as String,
  productImage: json['product_image'] as String,
  qty: json['qty'] as num,
  price: json['price'] as num,
  subtotal: json['subtotal'] as num,
);

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
  'line_id': instance.lineId,
  'product_id': instance.productId,
  'product_name': instance.productName,
  'product_image': instance.productImage,
  'qty': instance.qty,
  'price': instance.price,
  'subtotal': instance.subtotal,
};
