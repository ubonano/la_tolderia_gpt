import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

// Repositories
import '../modules/auth/auth_repository.dart';
import '../modules/branch/branch_repository.dart';
import '../modules/daily_income/daily_income_repository.dart';
import '../modules/employee/employee_repository.dart';
import '../modules/point_of_sale/point_of_sale_repository.dart';
import '../modules/point_of_sale/point_of_sale_service.dart';
import '../modules/user/user_repository.dart';

// Services
import '../modules/auth/auth_service.dart';
import '../modules/branch/branch_service.dart';
import '../modules/daily_income/daily_income_service.dart';
import '../modules/employee/employee_service.dart';
import '../modules/user/user_service.dart';

GetIt locator = GetIt.instance;

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuthSecondary =
    FirebaseAuth.instanceFor(app: Firebase.app('SecondaryApp'));

HttpsCallable deleteUserFunction =
    FirebaseFunctions.instance.httpsCallable('deleteUser');

void setupLocator() {
  // Register repositories
  _registerRepositories();

  // Register services
  _registerServices();
}

void _registerRepositories() {
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepository(firebaseAuth: firebaseAuth),
  );

  locator.registerLazySingleton<BranchRepository>(
    () => BranchRepository(firebaseFirestore: firebaseFirestore),
  );

  locator.registerLazySingleton<DailyIncomeRepository>(
    () => DailyIncomeRepository(firebaseFirestore: firebaseFirestore),
  );

  locator.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepository(firebaseFirestore: firebaseFirestore),
  );

  locator.registerLazySingleton<UserRepository>(
    () => UserRepository(
      firestore: firebaseFirestore,
      firebaseAuth: firebaseAuthSecondary,
      deleteUserFunction: deleteUserFunction,
    ),
  );

  locator.registerLazySingleton<PointOfSaleRepository>(
    () => PointOfSaleRepository(firebaseFirestore: firebaseFirestore),
  );
}

void _registerServices() {
  locator.registerLazySingleton<AuthService>(
    () => AuthService(authRepository: locator<AuthRepository>()),
  );

  locator.registerLazySingleton<BranchService>(
    () => BranchService(branchRepository: locator<BranchRepository>()),
  );

  locator.registerLazySingleton<DailyIncomeService>(
    () => DailyIncomeService(
      dailyIncomeRepository: locator<DailyIncomeRepository>(),
    ),
  );

  locator.registerLazySingleton<EmployeeService>(
    () => EmployeeService(
      employeeRepository: locator<EmployeeRepository>(),
    ),
  );

  locator.registerLazySingleton<UserService>(
    () => UserService(
      userRepository: locator<UserRepository>(),
    ),
  );

  locator.registerLazySingleton<PointOfSaleService>(
    () => PointOfSaleService(
      pointOfSaleRepository: locator<PointOfSaleRepository>(),
    ),
  );
}
