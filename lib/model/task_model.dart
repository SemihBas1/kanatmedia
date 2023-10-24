class Task {
  final String projectId;
  final String projectName;
  final String projectType;
  final String projectTitle;
  final String situation;
  final String resultSituation;
  final String createdDate;
  final String deliveryDate;
  final String customer;
  final String responsible1;
  final String? responsible2;

  Task({
    required this.projectId,
    required this.projectName,
    required this.projectType,
    required this.projectTitle,
    required this.situation,
    required this.resultSituation,
    required this.createdDate,
    required this.deliveryDate,
    required this.customer,
    required this.responsible1,
    this.responsible2,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        projectId: json['id'],
        projectName: json['proje_adi'],
        projectType: json['proje_turu'],
        projectTitle: json['gorev_aciklama'],
        situation: json['durum'],
        resultSituation: json['durumlar'],
        createdDate: json['verilis_tarihi'],
        deliveryDate: json['teslim_tarihi'],
        customer: json['musteri'],
        responsible1: json['sorumlu1'],
        responsible2: json['sorumlu2']);
  }
}
