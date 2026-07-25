import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const DashboardState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  DashboardState copyWith({
    int? selectedIndex,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}
