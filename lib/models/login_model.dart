class User {
  final int id;
  final String username;
  final String email;
  final String phone;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'token': token,
    };
  }
}