class User {
  final String id;
  final String username;
  final String password;
  final String position;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.position,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['email'],
      password: json['password'],
      position: json['position'],
    );
  }
}
