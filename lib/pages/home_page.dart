import 'package:flutter/material.dart';
import 'package:kanatmedia/data/fetch_user.dart';
import 'package:kanatmedia/model/user_model.dart';
import 'package:kanatmedia/pages/example.dart';
import 'package:kanatmedia/pages/login.dart';

class HomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HomePage> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
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
                            subtitle: Text(users[index].password),
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
