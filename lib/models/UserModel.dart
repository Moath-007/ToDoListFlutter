class UserModel {
  final String status;
  final String message;
  final String? id;
  final String? username;

  UserModel({required this.status, required this.message, this.id, this.username});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      id: json['id']?.toString(),
      username: json['username']?.toString(),
    );
  }
}