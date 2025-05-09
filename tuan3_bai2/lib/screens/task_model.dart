

class Task {
  final int id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final String category;
  final DateTime dueDate;
  final String desImageURL;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Subtask> subtasks;
  final List<Attachment> attachments;
  final List<Reminder> reminders;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.category,
    required this.dueDate,
    required this.desImageURL,
    required this.createdAt,
    required this.updatedAt,
    required this.subtasks,
    required this.attachments,
    required this.reminders,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'No Title',
      description: json['description'] as String? ?? 'No Description',
      status: json['status'] as String? ?? 'Unknown',
      priority: json['priority'] as String? ?? 'Low',
      category: json['category'] as String? ?? 'General',
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : DateTime.now(),
      desImageURL: json['desImageURL'] as String? ?? '',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
      subtasks: (json['subtasks'] as List<dynamic>?)
              ?.map((item) => Subtask.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((item) => Attachment.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      reminders: (json['reminders'] as List<dynamic>?)
              ?.map((item) => Reminder.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class Subtask {
  final int id;
  final String title;
  final bool isCompleted;

  Subtask({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  factory Subtask.fromJson(Map<String, dynamic> json) {
    return Subtask(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'Untitled',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}

class Attachment {
  final int id;
  final String fileName;
  final String fileUrl;

  Attachment({
    required this.id,
    required this.fileName,
    required this.fileUrl,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'] as int? ?? 0,
      fileName: json['fileName'] as String? ?? 'Unknown File',
      fileUrl: json['fileUrl'] as String? ?? '',
    );
  }
}

class Reminder {
  final int id;
  final DateTime time;
  final String type;

  Reminder({
    required this.id,
    required this.time,
    required this.type,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'] as int? ?? 0,
      time: json['time'] != null ? DateTime.parse(json['time']) : DateTime.now(),
      type: json['type'] as String? ?? 'Notification',
    );
  }
}
