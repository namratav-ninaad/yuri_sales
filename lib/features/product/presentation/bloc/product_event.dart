import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/product/domain/entities/add_cart_data.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends ProductEvent {
  final String query;

  FetchProductsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class AddCartEvent extends ProductEvent {
  final AddCartData data;

  AddCartEvent(this.data);
}
