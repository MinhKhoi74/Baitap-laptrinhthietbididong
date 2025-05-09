import 'package:flutter/material.dart';
import '../db/app_database.dart';
import '../db/models/task.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _handleAdd() async {
  String title = _titleController.text;
  String desc = _descriptionController.text;

  if (title.isEmpty || desc.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("❗ Vui lòng điền đầy đủ thông tin")),
    );
    return;
  }

  try {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final taskDao = database.taskDao;

    final newTask = Task(
      null,
      title,
      desc,
      DateTime.now(),
      false,
    );

    await taskDao.insertTask(newTask);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("✅ Đã thêm task: $title")),
    );

    Navigator.pop(context); // Quay lại màn hình trước
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("❌ Thêm task thất bại: $e")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Task", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter task title",
              ),
            ),
            SizedBox(height: 16),
            Text("Description", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter task description",
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _handleAdd,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Add"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
