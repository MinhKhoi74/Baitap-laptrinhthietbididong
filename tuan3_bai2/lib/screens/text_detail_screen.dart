import 'package:flutter/material.dart';

class TextDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Text Detail",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              
            ),
            padding: EdgeInsets.all(10),
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 35, color: Colors.black),
                children: [
                  TextSpan(text: "The "),
                  TextSpan(
                    text: "quick ",
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                  TextSpan(
                    text: "Brown",
                    style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "\nfox j u m p s "),
                  TextSpan(
                    text: "over",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "\nthe ", style: TextStyle(decoration: TextDecoration.underline)),
                  TextSpan(
                    text: "lazy",
                    style: TextStyle(fontStyle: FontStyle.italic, ),
                  ),
                  TextSpan(text: " dog."),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
