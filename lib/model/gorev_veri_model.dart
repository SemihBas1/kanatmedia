class GorevVeri {
  final String projeAdi;
  final String projeTuru;
  final String durum;

  GorevVeri({
    required this.projeAdi,
    required this.projeTuru,
    required this.durum,
  });

  factory GorevVeri.fromJson(Map<String, dynamic> json) {
    return GorevVeri(
      projeAdi: json['proje_adi'] ?? "",
      projeTuru: json['proje_turu'] ?? "",
      durum: json['durum'] ?? "",
    );
  }
}
