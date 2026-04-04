class SignUpState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  SignUpState({this.isLoading = false, this.error, this.isSuccess = false});

  SignUpState copyWith({bool? isLoading, String? error, bool? isSuccess}) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
