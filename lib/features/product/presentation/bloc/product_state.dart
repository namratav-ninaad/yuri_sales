import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/cart/data/model/cart.dart';
import 'package:yuri_sale/features/product/data/model/product_model.dart';

class ProductState extends Equatable {
  final bool isLoading;
  final int? loadingProductId;
  final List<ProductModel> products;
  final String? errorMessage;
  final String searchQuery;

  const ProductState({
    this.isLoading = false,
    this.products = const [],
    this.errorMessage,
    this.searchQuery = '',
    this.loadingProductId,
  });

  ProductState copyWith({
    bool? isLoading,
    List<ProductModel>? products,
    String? errorMessage,
    String? searchQuery,
    int? loadingProductId,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      loadingProductId: loadingProductId,
      products: products ?? this.products,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    loadingProductId,
    isLoading,
    products,
    errorMessage,
    searchQuery,
  ];
}
