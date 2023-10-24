import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kanatmedia/data/fetch_user.dart';
import 'package:kanatmedia/model/gorev_veri_model.dart'; // Yeni model sınıfını içe aktarın
import 'package:kanatmedia/pages/example.dart';
import 'package:kanatmedia/pages/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<GorevVeri>> futureGorevler; // Future tipini GorevVeri olarak güncelleyin

  @override
  void initState() {
    super.initState();
    futureGorevler = fetchGorevler();

    // fetchUsers yerine fetchGorevler kullanın
  }
  Future<List<GorevVeri>> fetchGorevler() async {
    final response = await http.get(Uri.parse("http://192.168.37.212/veri.php"));

    if (response.statusCode == 200) {
      Iterable jsonList = json.decode(response.body);
      List<GorevVeri> gorevler = jsonList.map((model) => GorevVeri.fromJson(model)).toList();
      return gorevler;
    } else {
      throw Exception("Veri çekme hatası: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Görev Listesi', // Başlığı güncelleyin
      home: Scaffold(
        appBar: AppBar(
          title: Text('Görev Listesi'), // Başlığı güncelleyin
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
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text('Login Ekranına Git'),
                ),
              ),
              SizedBox(height: 20), // Biraz boşluk ekleyebilirsiniz
              Expanded(
                child: FutureBuilder<List<GorevVeri>>( // Future tipini GorevVeri olarak güncelleyin
                  future: futureGorevler, // futureUsers yerine futureGorevler kullanın
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Veri getirilirken bir hata oluştu: ${snapshot.error}');
                    } else {
                      return GorevVeriDataTable(gorevler: snapshot.data ?? []);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GorevVeriDataTable extends StatelessWidget {
  final List<GorevVeri> gorevler; // users yerine gorevler kullanın

  GorevVeriDataTable({required this.gorevler});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Proje Adı')),
        DataColumn(label: Text('Proje Türü')),
        DataColumn(label: Text('Durum')),
      ],
      rows: gorevler.map((gorev) => DataRow(
        cells: [
          DataCell(Text(gorev.projeAdi ?? "Veri Bulunamadı")),
          DataCell(Text(gorev.projeTuru ?? "Veri Bulunamadı")),
          DataCell(Text(gorev.durum ?? "Veri Bulunamadı")),
        ],
      )).toList(),
    );
  }
}
