// class TaskEntity {
//   final String id;
//   final String title;
//   final bool isCompleted;
//   final String? review;
//
//   TaskEntity({
//     required this.id,
//     required this.title,
//     this.isCompleted = false,
//     this.review,
//   });
// }


class TaskEntity {
  final String id;
  final String title;
  final String? description;
  final int isCompleted;
  final String? review;

  TaskEntity({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = 0,
    this.review,
  });

  // Add copyWith method
  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    int? isCompleted,
    String? review,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? 0,
      review: review ?? this.review,
    );
  }
}
