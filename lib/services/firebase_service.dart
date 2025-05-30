import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trexxo_mobility/models/user_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // FirebaseAuth getters
  User? get currentUser => _auth.currentUser;
  bool get isLoggedIn => currentUser != null;

  // Sign In
  Future<User?> signIn(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  // Register and create user in Firestore
  Future<User?> register(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.user;
  }

  // Fetch user model from Firestore
  Future<UserModel?> fetchUserModel() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;

    return UserModel.fromJson(doc.data()!);
  }

  Future<void> signOut() async => _auth.signOut();

  Future<void> sendPasswordResetEmail(String email) async =>
      _auth.sendPasswordResetEmail(email: email);

  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<bool> waitForEmailVerification(User user) async {
    bool isVerified = false;
    while (!isVerified) {
      await Future.delayed(const Duration(seconds: 3));
      await user.reload();
      final refreshedUser = FirebaseAuth.instance.currentUser;

      if (refreshedUser != null && refreshedUser.emailVerified) {
        isVerified = true;
      }
    }
    return isVerified;
  }
}
