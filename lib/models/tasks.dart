class Tasks {
  Tasks({required this.title, required this.date});

  Tasks.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        date = DateTime.parse(json['datetime']);

  String title;
  DateTime date;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'datetime': date.toIso8601String(),
    };
  }
}
