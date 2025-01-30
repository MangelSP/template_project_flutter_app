class AuthResponseModel {
  final String token;

  AuthResponseModel(this.token);

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(json['token']);
  }
}
