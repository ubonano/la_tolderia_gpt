import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import 'employee.dart';
import 'employee_repository.dart';

class EmployeeService {
  final EmployeeRepository _employeeRepository;
  final Logger _logger = Logger('EmployeeService');

  final BehaviorSubject<List<Employee>> _employeesSubject =
      BehaviorSubject.seeded([]);

  EmployeeService({required EmployeeRepository employeeRepository})
      : _employeeRepository = employeeRepository {
    _loadEmployees();
  }
  Stream<List<Employee>> get employeesStream => _employeesSubject.stream;

  void _loadEmployees() async {
    _logger.info('Loading employees');

    _employeeRepository.getEmployees().listen((employees) {
      _employeesSubject.add(employees);
      _logger.info('Employees loaded');
    }).onError((e) {
      _logger.warning('Error loading employees: $e');
      throw e;
    });
  }

  Future<void> addEmployee(Employee employee) {
    _logger.info('Adding employee');

    return _employeeRepository.addEmployee(employee).then((_) {
      _logger.info('Employee added');
    }).catchError((e) {
      _logger.warning('Error adding employee: $e');
      throw e;
    });
  }

  Future<void> updateEmployee(Employee employee) {
    _logger.info('Updating employee');

    return _employeeRepository.updateEmployee(employee).then((_) {
      _logger.info('Employee updated');
    }).catchError((e) {
      _logger.warning('Error updating employee: $e');
      throw e;
    });
  }

  Future<void> deleteEmployee(String employeeId) {
    _logger.info('Deleting employee');

    return _employeeRepository.deleteEmployee(employeeId).then((_) {
      _logger.info('Employee deleted');
    }).catchError((e) {
      _logger.warning('Error deleting employee: $e');
      throw e;
    });
  }

  void dispose() {
    _employeesSubject.close();
    _logger.info('Disposed EmployeeService');
  }
}
