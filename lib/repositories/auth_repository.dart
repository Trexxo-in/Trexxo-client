import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trexxo_mobility/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  /// Returns currently signed-in Firebase user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Signs out user
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Fetch full UserModel from Firestore
  Future<UserModel?> getCurrentUserData() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;

    return UserModel.fromJson(doc.data()!);
  }

  /// Example login method (can be replaced with real login logic)
  Future<UserModel?> signInWithEmail(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final uid = userCredential.user?.uid;
    if (uid == null) return null;

    final userDoc = await _firestore.collection('users').doc(uid).get();
    if (!userDoc.exists) return null;

    return UserModel.fromJson(userDoc.data()!);
  }
}
