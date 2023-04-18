import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

import 'daily_income.dart';

class DailyIncomeRepository {
  final FirebaseFirestore _firebaseFirestore;
  final Logger _logger = Logger('DailyIncomeService');

  DailyIncomeRepository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  CollectionReference<Map<String, dynamic>> get _dailyIncomeCollection =>
      _firebaseFirestore.collection('dailyIncomes');

  Stream<List<DailyIncome>> getDailyIncomes() {
    _logger.info('Getting daily incomes');
    return _dailyIncomeCollection
        .orderBy('date', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => DailyIncome.fromDocumentSnapshot(doc))
            .toList())
        .handleError((e) {
      _logger.warning('Error getting daily incomes: $e');
      throw e;
    });
  }

  Future<bool> dailyIncomeExists(DateTime date) async {
    try {
      _logger.info('Checking if daily income exists for date: $date');
      final querySnapshot = await _dailyIncomeCollection
          .where('date', isEqualTo: Timestamp.fromDate(date))
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      _logger.warning('Error checking daily income existence: $e');
      rethrow;
    }
  }

  Future<void> addDailyIncome(DailyIncome dailyIncome) async {
    try {
      _logger.info('Adding daily income');
      await _dailyIncomeCollection.add(dailyIncome.toMap());
      _logger.info('Daily income added');
    } catch (e) {
      _logger.warning('Error adding daily income: $e');
      rethrow;
    }
  }

  Future<void> updateDailyIncome(DailyIncome dailyIncome) async {
    try {
      _logger.info('Updating daily income');
      await _dailyIncomeCollection
          .doc(dailyIncome.id)
          .update(dailyIncome.toMap());
      _logger.info('Daily income updated');
    } catch (e) {
      _logger.warning('Error updating daily income: $e');
      rethrow;
    }
  }

  Future<void> deleteDailyIncome(String id) async {
    try {
      _logger.info('Deleting daily income');
      await _dailyIncomeCollection.doc(id).delete();
      _logger.info('Daily income deleted');
    } catch (e) {
      _logger.warning('Error deleting daily income: $e');
      rethrow;
    }
  }
}
