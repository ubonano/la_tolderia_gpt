import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import 'app_user.dart';
import 'user_repository.dart';

class UserService {
  final UserRepository _userRepository;
  final Logger _logger = Logger('UserService');

  final BehaviorSubject<List<AppUser>> _usersSubject =
      BehaviorSubject<List<AppUser>>();

  Stream<List<AppUser>> get usersStream => _usersSubject.stream;

  UserService({required UserRepository userRepository})
      : _userRepository = userRepository {
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    _logger.info('Loading users');
    _userRepository.getUsersStream().listen((dailyIncomes) {
      _usersSubject.add(dailyIncomes);
      _logger.info('Users loaded');
    }).onError((error, stackTrace) {
      _logger.warning('Error loading users: $error', error, stackTrace);
      throw error;
    });
  }

  Future<AppUser?> registerUser(AppUser appUser) async {
    _logger.info('Registering user');
    try {
      AppUser? newUser =
          await _userRepository.registerUser(appUser);
      _logger.info('User registered successfully');
      return newUser;
    } catch (e) {
      _logger.warning('Error in UserService registerUser: $e');
      rethrow;
    }
  }

  Future<void> deleteUser(String uid) async {
    _logger.info('Deleting user');
    try {
      await _userRepository.deleteUser(uid);
      _logger.info('User deleted successfully');
    } catch (e) {
      _logger.warning('Error in UserService deleteUser: $e');
      rethrow;
    }
  }

  void dispose() {
    _usersSubject.close();
    _logger.info('Disposed UserService');
  }
}
