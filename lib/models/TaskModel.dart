class TaskModel {
  final String id;
  final String title;
  final String description;
  final String userId;

  TaskModel({required this.id, required this.title, required this.description, required this.userId});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      userId: json['user_id'].toString(),
    );
  }
}