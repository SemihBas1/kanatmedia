import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kanatmedia/model/user_model.dart';

Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('192.168.37.212/veri.php'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    List<User> users = data.map((userData) => User.fromJson(userData)).toList();
    return users;
  } else {
    throw Exception('Veriler alınamadı');
  }
}
