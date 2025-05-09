import 'package:floor/floor.dart';
import 'models/task.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM Task')
  Future<List<Task>> getAllTasks();

  @insert
  Future<void> insertTask(Task task);
}
