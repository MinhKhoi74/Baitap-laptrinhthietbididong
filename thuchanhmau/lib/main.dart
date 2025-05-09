import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ThemeSettingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ThemeSettingScreen extends StatefulWidget {
  @override
  _ThemeSettingScreenState createState() => _ThemeSettingScreenState();
}

class _ThemeSettingScreenState extends State<ThemeSettingScreen> {
  int selectedIndex = -1;
  Color backgroundColor = Colors.white;

  final List<Color> themeColors = [
    Color(0xFF83C9FF), // light blue
    Color(0xFFE04FB3), // pink
    Color(0xFF1E1E1E), // black
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedTheme(); // load saved background color when app starts
  }

  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getInt('themeIndex') ?? -1;
    print('Loaded theme index: $savedIndex');

    if (savedIndex != -1 && savedIndex < themeColors.length) {
      setState(() {
        selectedIndex = savedIndex;
        backgroundColor = themeColors[savedIndex];
      });
    }
  }

  Future<void> _saveTheme(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeIndex', index);
    print('Saved theme index: $index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Setting',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Choosing the right theme sets the tone and personality of your app',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 13,
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(themeColors.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 60,
                    height: 50,
                    decoration: BoxDecoration(
                      color: themeColors[index],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: selectedIndex == index
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                if (selectedIndex != -1) {
                  setState(() {
                    backgroundColor = themeColors[selectedIndex];
                  });
                  _saveTheme(selectedIndex);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Apply',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
