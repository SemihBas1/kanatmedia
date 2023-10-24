class User {
  final String id;
  final String username;
  final String password;
  final String name;
  final String surname;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.surname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json[''],
      password: json['password'],
      name: json['name'],
      surname: json['surname'],
    );
  }
}
