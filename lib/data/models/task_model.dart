import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({required String id, required String title,bool isCompleted = false, String? review})
      : super(id: id, title: title,isCompleted: isCompleted, review: review);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
      review: json['review'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'review': review,
    };
  }
}
