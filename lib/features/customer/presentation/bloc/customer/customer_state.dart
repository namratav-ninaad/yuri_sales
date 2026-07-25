import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/customer/data/model/customer.dart';

class CustomerState extends Equatable {
  final bool isLoading;
  final List<CustomerModel> customers;
  final String? errorMessage;
  final String searchQuery;
  final bool isSuccess;

  const CustomerState({
    this.isLoading = false,
    this.isSuccess = false,
    this.customers = const [],
    this.errorMessage,
    this.searchQuery = '',
  });

  CustomerState copyWith({
    bool? isLoading,
    List<CustomerModel>? customers,
    String? errorMessage,
    bool? isSuccess,
    String? searchQuery,
  }) {
    return CustomerState(
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      customers: customers ?? this.customers,
    );
  }

  @override
  List<Object?> get props => [errorMessage, isLoading, customers, isSuccess];
}
