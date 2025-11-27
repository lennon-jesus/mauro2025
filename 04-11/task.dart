class Task {
  int? id;
  String title;
  String date;
  int done;

  Task({
    this.id,
    required this.title,
    required this.date,
    this.done = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "date": date,
      "done": done,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map["id"],
      title: map["title"],
      date: map["date"],
      done: map["done"],
    );
  }
}
