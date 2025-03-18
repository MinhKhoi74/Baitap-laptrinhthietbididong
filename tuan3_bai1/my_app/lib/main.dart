import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = "Hello"; // Văn bản ban đầu

  void _changeText() {
    setState(() {
      _text = "I'm\nĐoàn Minh Khôi"; // Thay đổi văn bản khi nhấn nút
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My First App",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            Text(
              _text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: _text == "Hello" ? FontWeight.normal : FontWeight.bold),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: _changeText,
              child: Text("Say Hi!"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
