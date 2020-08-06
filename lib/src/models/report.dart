class Report {
  int userId;
  int id;
  String title;

  Report({this.userId, this.id, this.title});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}