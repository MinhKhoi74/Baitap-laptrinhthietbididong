import 'package:floor/floor.dart';

@entity
class Task {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;
  final String description;
  final DateTime createdAt;
  final bool isDone;

  Task(this.id, this.title, this.description, this.createdAt, this.isDone);
}
