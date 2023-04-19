import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final Logger _logger = Logger('AuthRepository');

  AuthRepository({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  Stream<User?> get authStateChanges {
    _logger.info('Getting auth state changes');
    return _firebaseAuth.authStateChanges();
  }

  User? get currentUser {
    _logger.info('Getting current user');
    return _firebaseAuth.currentUser;
  }

  Future<User?> signUp(String email, String password) async {
    try {
      _logger.info('Signing up with email: $email');

      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      _logger.info('Sign up successful');

      return userCredential.user;
    } catch (e) {
      _logger.warning('Sign up failed: $e');
      rethrow;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      _logger.info('Signing in with email: $email');

      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      _logger.info('Sign in successful');

      return userCredential.user;
    } catch (e) {
      _logger.warning('Sign in failed: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      _logger.info('Signing out');

      await _firebaseAuth.signOut();

      _logger.info('Sign out successful');
    } catch (e) {
      _logger.warning('Sign out failed: $e');
      rethrow;
    }
  }
}
