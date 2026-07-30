class QuoteState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const QuoteState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  QuoteState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return QuoteState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}
