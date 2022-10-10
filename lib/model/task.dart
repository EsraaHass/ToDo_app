class Task {
  static const String collectionName = 'task';
  String id;

  String userId;

  String title;

  String description;

  DateTime dataTime;

  bool isDone;

  Task({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.dataTime,
    required this.isDone,
  });

  Task.fromFireStore(Map<String, dynamic> data, String id)
      : this(
          id: data['id'],
          userId: data['id'],
          title: data['title'],
          description: data['description'],
          dataTime: DateTime.fromMillisecondsSinceEpoch(data['dataTime']),
          isDone: data['isDone'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'userId':userId,
      'title': title,
      'description': description,
      'dataTime': dataTime.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }
}
