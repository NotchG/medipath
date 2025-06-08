class RegisterRequest {
  final String fullName;
  final String email;
  final String password;

  RegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'password': password,
  };
}

class RegisterResponse {
  final String message;
  final String id;
  final String fullName;
  final String email;

  RegisterResponse({
    required this.message,
    required this.id,
    required this.fullName,
    required this.email,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'],
      id: json['user']['id'],
      fullName: json['user']['fullName'],
      email: json['user']['email'],
    );
  }
}