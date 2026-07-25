import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final int selectedIndex;

  const HomeState({
    this.selectedIndex = 0,
  });

  HomeState copyWith({
    int? selectedIndex,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [
    selectedIndex,
  ];
}