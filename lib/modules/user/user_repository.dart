import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

import 'app_user.dart';

class UserRepository {
  final Logger _logger = Logger('UserRepository');
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final HttpsCallable _deleteUserFunction;

  UserRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
    required HttpsCallable deleteUserFunction,
  })  : _firestore = firestore,
        _firebaseAuth = firebaseAuth,
        _deleteUserFunction = deleteUserFunction;

  CollectionReference<Map<String, dynamic>> _usersCollection() =>
      _firestore.collection('users');

  Stream<List<AppUser>> getUsersStream() {
    _logger.info('Fetching users stream');
    return _usersCollection().snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return AppUser.fromDocumentSnapshot(doc);
      }).toList();
    }).handleError((error, stackTrace) {
      _logger.warning('Error fetching users stream: $error', error, stackTrace);
      throw error;
    });
  }

  Future<AppUser?> registerUser(AppUser appUser) async {
    _logger.info('Registering user');
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: appUser.email,
        password: appUser.password,
      );

      User? user = userCredential.user;

      final localAppUser = AppUser(
        uid: user!.uid,
        email: appUser.email,
        displayName: appUser.displayName,
      );

      await _usersCollection().doc(user.uid).set(localAppUser.toMap());

      _firebaseAuth.signOut();
      _logger.info('User registered successfully');

      return appUser;
    } catch (e) {
      _logger.warning('Error in UserRepository registerUser: $e');
      rethrow;
    }
  }

  Future<void> deleteUser(String userId) async {
    _logger.info('Deleting user');
    try {
      await _deleteUserFunction.call({'userId': userId});
      _logger.info('User deleted successfully');
    } catch (e) {
      _logger.warning('Error in UserRepository deleteUser: $e');
      throw e;
    }
  }
}
