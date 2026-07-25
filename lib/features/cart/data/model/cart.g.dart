// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
  cart_id: json['cart_id'] as num,
  cart_name: json['cart_name'] as String,
  total_items: json['total_items'] as num,
  amount_untaxed: json['amount_untaxed'] as num,
  amount_tax: json['amount_tax'] as num,
  amount_total: json['amount_total'] as num,
  currency: json['currency'] as String,
  cartProducts: (json['lines'] as List<dynamic>)
      .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
  'cart_id': instance.cart_id,
  'cart_name': instance.cart_name,
  'total_items': instance.total_items,
  'amount_untaxed': instance.amount_untaxed,
  'amount_tax': instance.amount_tax,
  'amount_total': instance.amount_total,
  'currency': instance.currency,
  'lines': instance.cartProducts,
};

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
  product_image: json['product_image'] as String,
  line_id: json['line_id'] as num,
  product_id: json['product_id'] as num,
  product_name: json['product_name'] as String,
  qty: json['qty'] as num,
  price: json['price'] as num,
  subtotal: json['subtotal'] as num,
);

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
  'product_image': instance.product_image,
  'line_id': instance.line_id,
  'product_id': instance.product_id,
  'product_name': instance.product_name,
  'qty': instance.qty,
  'price': instance.price,
  'subtotal': instance.subtotal,
};
