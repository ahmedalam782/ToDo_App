class AuthErrorModel {
  final String errorMsg;

  AuthErrorModel({
    required this.errorMsg,
  });

  factory AuthErrorModel.fromFireAuthException(String error) {
    return AuthErrorModel(errorMsg: error);
  }
}
