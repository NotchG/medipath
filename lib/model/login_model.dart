class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}

class LoginResponse {
  final String token;
  final String id;
  final String email;

  LoginResponse({required this.token, required this.id, required this.email});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      id: json['user']['id'].toString(),
      email: json['user']['email'],
    );
  }
}