import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kanatmedia/pages/example.dart';
import 'dart:convert';
import 'package:kanatmedia/utils/app_string.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kanatmedia/pages/task_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _message = '';

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    setState(() {
      _message = 'İstek gönderiliyor...';
    });

    try {
      final response = await http.post(
        Uri.parse(AppString().apiLink), // PHP API endpointinizi buraya ekleyin
        body: {
          'email': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success']) {
          setState(() {
            _message = 'Başarıyla giriş yaptınız!';
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
          });
        } else {
          setState(() {
            final errorMessage = responseData['message'];
            _message = 'Giriş başarısız: $errorMessage';
          });
        }
      } else {
        setState(() {
          _message = 'HTTP Hatası: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'İstek gönderilirken hata oluştu: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Kullanıcı Adı'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Şifre'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _login();
              },
              child: const Text('Giriş Yap'),
            ),
            const SizedBox(height: 16),
            Text(_message),
          ],
        ),
      ),
    );
  }
}



/**192.168.1.188 */