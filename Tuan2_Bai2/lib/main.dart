import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LibraryManagementScreen(),
    );
  }
}

class LibraryManagementScreen extends StatefulWidget {
  @override
  _LibraryManagementScreenState createState() =>
      _LibraryManagementScreenState();
}

class _LibraryManagementScreenState extends State<LibraryManagementScreen> {
  String selectedUser = "Nguyen Van A";
  List<String> books = ["Sách 01", "Sách 02"];
  List<bool> borrowedBooks = [false, false];

  void borrowBook(int index) {
    setState(() {
      borrowedBooks[index] = !borrowedBooks[index];
    });
  }

  void changeUser() {
    setState(() {
      selectedUser = selectedUser == "Nguyen Van A" ? "Le Thi B" : "Nguyen Van A";
    });
  }

  void addBook() {
    setState(() {
      books.add("Sách 0${books.length + 1}");
      borrowedBooks.add(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hệ thống Quản lý Thư viện"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chọn nhân viên
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Nhân viên", style: TextStyle(fontSize: 18)),
                Row(
                  children: [
                    Text(selectedUser, style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: changeUser,
                      child: const Text("Đổi"),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Text("Danh sách sách", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            // Danh sách sách
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        borrowedBooks[index] ? Icons.check_box : Icons.check_box_outline_blank,
                        color: Colors.blue,
                      ),
                      title: Text(books[index]),
                      trailing: ElevatedButton(
                        onPressed: () => borrowBook(index),
                        child: Text(borrowedBooks[index] ? "Trả" : "Mượn"),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Nút thêm sách
            Center(
              child: ElevatedButton(
                onPressed: addBook,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text("Thêm", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),

      // Thanh điều hướng
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Quản lý"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "DS Sách"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Nhân viên"),
        ],
      ),
    );
  }
}
