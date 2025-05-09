import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email', 
      'profile',
      'https://www.googleapis.com/auth/user.birthday.read', // Thêm scope để lấy ngày sinh
    ],
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Hàm đăng nhập với Google
  Future<User?> signInWithGoogle() async {
    try {
      // Đăng nhập Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // Người dùng hủy đăng nhập

      // Lấy thông tin xác thực từ Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Đăng nhập vào Firebase bằng thông tin xác thực Google
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (error) {
      print("Lỗi đăng nhập Google: $error");
      return null;
    }
  }

  // Hàm đăng xuất
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
