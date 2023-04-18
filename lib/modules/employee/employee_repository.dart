import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

import 'employee.dart';

class EmployeeRepository {
  final FirebaseFirestore _firebaseFirestore;
  final Logger _logger = Logger('EmployeeRepository');

  EmployeeRepository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  CollectionReference<Map<String, dynamic>> get _employeeCollection =>
      _firebaseFirestore.collection('employees');

  Stream<List<Employee>> getEmployees() {
    _logger.info('Getting employees');
    return _employeeCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Employee.fromDocument(doc.data(), doc.id);
      }).toList();
    }).handleError((e) {
      _logger.warning('Error getting employees: $e');
      throw e;
    });
  }

  Future<void> addEmployee(Employee employee) {
    _logger.info('Adding employee');
    return _employeeCollection.add(employee.toMap()).catchError((e) {
      _logger.warning('Error adding employee: $e');
      throw e;
    }).then((_) => _logger.info('Employee added'));
  }

  Future<void> updateEmployee(Employee employee) {
    _logger.info('Updating employee');
    return _employeeCollection
        .doc(employee.id)
        .update(employee.toMap())
        .catchError((e) {
      _logger.warning('Error updating employee: $e');
      throw e;
    }).then((_) => _logger.info('Employee updated'));
  }

  Future<void> deleteEmployee(String employeeId) {
    _logger.info('Deleting employee');
    return _employeeCollection.doc(employeeId).delete().catchError((e) {
      _logger.warning('Error deleting employee: $e');
      throw e;
    }).then((_) => _logger.info('Employee deleted'));
  }
}
