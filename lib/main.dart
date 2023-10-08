import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart' ;

void main() {
  runApp(MyApp());
}

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
      username: json['username'],
      password: json['password'],
      position: json['position'],
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('http://192.168.1.39/veri.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<User> users = data.map((userData) => User.fromJson(userData)).toList();
      return users;
    } else {
      throw Exception('Veriler alınamadı');
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List',
      home: Scaffold(
        appBar: AppBar(
          title: Text('User List'),
        ),
        body: Center(


          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(

                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    print("Butona tıklandı");
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
                  },
                  child: Text('Login Ekranına Git'),
                ),
              ),
              FutureBuilder<List<User>>(
                future: futureUsers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Hata: ${snapshot.error}');
                  } else {
                    final users = snapshot.data;
                    if (users == null) {
                      return Text('Veriler bulunamadı');
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(users[index].username),
                            subtitle: Text(users[index].position),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        
      ),
      
      
    );
    
    
    
  }
  
  
}
