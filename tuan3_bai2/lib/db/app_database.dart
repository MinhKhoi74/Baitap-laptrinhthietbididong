import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import './models/task.dart';
import 'task_dao.dart';
import './type_converters/date_time_converter.dart'; // Nếu bạn dùng DateTime converter

part 'app_database.g.dart'; // Sẽ được generate

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Task])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}
