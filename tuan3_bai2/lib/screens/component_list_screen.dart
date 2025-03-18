import 'package:flutter/material.dart';
import 'text_detail_screen.dart'; // Import màn hình mới

class ComponentListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "UI Components List",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
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
            _buildCategoryTitle("Display"),
            _buildComponentCard(context, "Text", "Displays text"), // Thêm context
            _buildComponentCard(context, "Image", "Displays an image"),
            _buildCategoryTitle("Input"),
            _buildComponentCard(context, "TextField", "Input field for text"),
            _buildComponentCard(context, "PasswordField", "Input field for passwords"),
            _buildCategoryTitle("Layout"),
            _buildComponentCard(context, "Column", "Arranges elements vertically"),
            _buildComponentCard(context, "Row", "Arranges elements horizontally"),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildComponentCard(BuildContext context, String title, String description) {
    return Card(
      color: Colors.blue.shade100,
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        onTap: () {
          if (title == "Text") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TextDetailScreen()),
            );
          }
        },
      ),
    );
  }
}
