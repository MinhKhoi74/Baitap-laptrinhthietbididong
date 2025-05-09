import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'google_sign_in_provider.dart';
import 'component_list_screen.dart'; // Đảm bảo file này chứa danh sách các component
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignInProvider googleSignInProvider = GoogleSignInProvider();
  User? _user;
  String? _birthday;

  TextEditingController emailController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  void _handleGoogleSignIn() async {
    User? user = await googleSignInProvider.signInWithGoogle();
    if (user != null) {
      setState(() {
        _user = user;
        _birthday = user.metadata.creationTime?.toLocal().toString();
        emailController.text = user.email ?? '';
        birthdayController.text = _birthday ?? 'Không có thông tin';
      });
      Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ComponentListScreen()),
              );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đăng nhập thành công!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đăng nhập thất bại!')));
    }
  }

  void _handleSignOut() async {
    await googleSignInProvider.signOut();
    setState(() {
      _user = null;
      _birthday = null;
    });
    emailController.clear();
    birthdayController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng nhập với Google')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/image.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            _user == null
                ? ElevatedButton(
                    onPressed: _handleGoogleSignIn,
                    child: Text('Đăng nhập với Google'),
                  )
                : Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(_user!.photoURL ?? ''),
                        radius: 40,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Xin chào, ${_user!.displayName ?? 'Người dùng'}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextField(
                        controller: emailController,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Email của bạn',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ngày sinh:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextField(
                        controller: birthdayController,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Ngày sinh của bạn',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _handleSignOut,
                        child: Text('Đăng xuất'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
