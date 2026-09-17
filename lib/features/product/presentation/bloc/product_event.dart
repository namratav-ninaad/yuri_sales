import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/product/data/model/category.dart' as category_model;
import 'package:yuri_sale/features/product/domain/entities/add_cart_data.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends ProductEvent {
  final String query;
  final int? categoryId;

  FetchProductsEvent({required this.query, this.categoryId});

  @override
  List<Object?> get props => [query];
}

class FetchCategoriesEvent extends ProductEvent {}

class AddCartEvent extends ProductEvent {
  final AddCartData data;

  AddCartEvent(this.data);
}

class SelectCategoryEvent extends ProductEvent {
  final category_model.CategoryModel category;

  SelectCategoryEvent(this.category);
}

class RemoveProductFromCart extends ProductEvent {
  final num productId;

  RemoveProductFromCart({ required this.productId});

  @override
  List<Object?> get props => [productId];
}

class IncreaseProductQuantity extends ProductEvent {
  final num productId;

  IncreaseProductQuantity({
    required this.productId,
  });
}

class SetProductQuantity extends ProductEvent {
  final int productId;
  final int quantity;

  SetProductQuantity({
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [productId, quantity];
}

class DecreaseProductQuantity extends ProductEvent {
  final num productId;

  DecreaseProductQuantity({
    required this.productId,
  });
}

class SyncCartDataToProducts extends ProductEvent {
  final Map<int, int> cartQuantities;
  final Map<int, int> lineIds;

  SyncCartDataToProducts({
    required this.cartQuantities,
    required this.lineIds,
  });

  @override
  List<Object?> get props => [
    cartQuantities,
    lineIds,
  ];
}