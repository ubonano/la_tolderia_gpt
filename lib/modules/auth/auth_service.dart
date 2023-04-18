import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';
import 'auth_repository.dart';

class AuthService {
  final AuthRepository _authRepository;
  final Logger _logger = Logger('AuthService');

  AuthService({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Stream<User?> get authStateChanges {
    _logger.info('Getting auth state changes');
    return _authRepository.authStateChanges;
  }

  User? get currentUser {
    _logger.info('Getting current user');
    return _authRepository.currentUser;
  }

  Future<User?> signUp(String email, String password) {
    _logger.info('Signing up with email: $email');
    return _authRepository.signUp(email, password);
  }

  Future<User?> signIn(String email, String password) {
    _logger.info('Signing in with email: $email');
    return _authRepository.signIn(email, password);
  }

  Future<void> signOut() {
    _logger.info('Signing out');
    return _authRepository.signOut();
  }
}
