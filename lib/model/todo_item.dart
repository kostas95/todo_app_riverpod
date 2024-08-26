class TodoItem {
  late String id;
  String? title;
  bool completed = false;

  TodoItem({
    required this.title,
    this.completed = false,
  });

  TodoItem.fromJson(dynamic json) {
    if (json is Map) {
      id = json['id'];
      title = json['title'];
      completed = json['completed'];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}
