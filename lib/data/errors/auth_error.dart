enum AuthErrorType {
  invalid,
  blocked,
  expired,
}

class AuthError implements Exception {
  final AuthErrorType errorType;
  final String message;
  AuthError({required this.errorType, required this.message});
}
