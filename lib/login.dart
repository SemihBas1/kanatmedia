import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(LoginScreen());
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://localhost/login.php'),
      body: {
        'username': username,
        'password': password,
      },
    );

    final data = json.decode(response.body);

    if (data['success'] == true) {
      // Giriş başarılı
      print('Giriş başarılı');
    } else {
      // Giriş başarısız
      print('Kullanıcı adı veya şifre yanlış');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kullanıcı Girişi'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Şifre'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: _login,
                child: Text('Giriş Yap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
