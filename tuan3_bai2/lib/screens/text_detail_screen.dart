import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'task_model.dart';
import 'no_task_widget.dart';

class TextDetailScreen extends StatefulWidget {
  final int taskId;

  TextDetailScreen({required this.taskId});

  @override
  _TextDetailScreenState createState() => _TextDetailScreenState();
}

class _TextDetailScreenState extends State<TextDetailScreen> {
  late Future<Task?> futureTask;
  String? errorMessage; // Biến để lưu thông báo lỗi

  @override
  void initState() {
    super.initState();
    futureTask = fetchTask(widget.taskId);
  }

 Future<Task?> fetchTask(int id) async {
  try {
    final response = await http.get(Uri.parse('https://amock.io/api/researchUTH/task/$id'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Nếu isSuccess = false hoặc data = null
      if (jsonData == null || jsonData['isSuccess'] != true || jsonData['data'] == null) {
        setState(() {
          errorMessage = jsonData['message'] ?? 'Không thể lấy dữ liệu công việc.';
        });
        return null;
      }

      return Task.fromJson(jsonData['data']);
    } else {
      setState(() {
        errorMessage = "Lỗi mạng: Mã trạng thái ${response.statusCode}";
      });
      return null;
    }
  } catch (e) {
    setState(() {
      errorMessage = "Lỗi khi gọi API: $e";
    });
    return null;
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chi tiết Công Việc')),
      body: FutureBuilder<Task?>(
        future: futureTask,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            // Hiển thị thông báo lỗi từ API hoặc widget mặc định
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  errorMessage ?? 'Không có dữ liệu công việc.',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          Task task = snapshot.data!;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (task.desImageURL.isNotEmpty)
                  Image.network(task.desImageURL, height: 200, width: double.infinity, fit: BoxFit.cover),

                SizedBox(height: 10),
                Text(task.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(task.description, style: TextStyle(fontSize: 16)),
                Text("Trạng thái: ${task.status}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Ưu tiên: ${task.priority}", style: TextStyle(fontSize: 16)),
                Text("Danh mục: ${task.category}", style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),

                // Subtasks
                Text("Công việc con:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                if (task.subtasks.isNotEmpty)
                  ...task.subtasks.map((subtask) => ListTile(
                        leading: Icon(
                          subtask.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: subtask.isCompleted ? Colors.green : Colors.red,
                        ),
                        title: Text(subtask.title),
                      ))
                else
                  Text("Không có công việc con", style: TextStyle(color: Colors.grey)),

                SizedBox(height: 20),

                // Attachments
                if (task.attachments.isNotEmpty) ...[
                  Text("Tệp đính kèm:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ...task.attachments.map((attachment) => ListTile(
                        title: Text(attachment.fileName),
                        trailing: Icon(Icons.attach_file),
                        onTap: () => print("Mở ${attachment.fileUrl}"),
                      )),
                ] else
                  Text("Không có tệp đính kèm", style: TextStyle(color: Colors.grey)),

                SizedBox(height: 20),

                // Reminders
                if (task.reminders.isNotEmpty) ...[
                  Text("Nhắc nhở:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ...task.reminders.map((reminder) => ListTile(
                        title: Text("Nhắc lúc ${reminder.time}"),
                        subtitle: Text("Loại: ${reminder.type}"),
                      )),
                ] else
                  Text("Không có nhắc nhở", style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }
}
