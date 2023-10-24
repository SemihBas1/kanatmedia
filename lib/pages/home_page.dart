import 'package:flutter/material.dart';
import 'package:kanatmedia/pages/login.dart';
import 'package:kanatmedia/utils/app_string.dart';

class HomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(AppString().goLogin),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/**
 *   late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

 */

/*  FutureBuilder<List<User>>(
                future: futureUsers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Hata: ${snapshot.error}');
                  } else {
                    final users = snapshot.data;
                    if (users == null) {
                      return const Text('Veriler bulunamadı');
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
              ),*/