import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/product/data/model/category.dart';
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
  final CategoryModel category;

  SelectCategoryEvent(this.category);
}
