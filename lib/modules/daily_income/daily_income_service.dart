import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import 'daily_income.dart';
import 'daily_income_repository.dart';

class DailyIncomeService {
  final DailyIncomeRepository _dailyIncomeRepository;
  final Logger _logger = Logger('DailyIncomeService');

  final BehaviorSubject<List<DailyIncome>> _dailyIncomesSubject =
      BehaviorSubject<List<DailyIncome>>();

  DailyIncomeService({required DailyIncomeRepository dailyIncomeRepository})
      : _dailyIncomeRepository = dailyIncomeRepository {
    _loadDailyIncomes();
  }

  Future<void> _loadDailyIncomes() async {
    _logger.info('Loading daily incomes');
    _dailyIncomeRepository.getDailyIncomes().listen((dailyIncomes) {
      _dailyIncomesSubject.add(dailyIncomes);
      _logger.info('Daily incomes loaded');
    }).onError((e) {
      _logger.warning('Error loading daily incomes: $e');
      throw e;
    });
  }

  Stream<List<DailyIncome>> getDailyIncomes() {
    return _dailyIncomesSubject.stream;
  }

  Future<bool> dailyIncomeExists(DateTime date) {
    _logger.info('Checking if daily income exists for date: $date');
    return _dailyIncomeRepository.dailyIncomeExists(date).catchError((e) {
      _logger.warning('Error checking daily income existence: $e');
      throw e;
    });
  }

  Future<void> addDailyIncome(DailyIncome dailyIncome) async {
    _logger.info('Adding daily income');
    await _dailyIncomeRepository.addDailyIncome(dailyIncome).catchError((e) {
      _logger.warning('Error adding daily income: $e');
      throw e;
    });
    _logger.info('Daily income added');
  }

  Future<void> updateDailyIncome(DailyIncome dailyIncome) async {
    _logger.info('Updating daily income');
    await _dailyIncomeRepository.updateDailyIncome(dailyIncome).catchError((e) {
      _logger.warning('Error updating daily income: $e');
      throw e;
    });
    _logger.info('Daily income updated');
  }

  Future<void> deleteDailyIncome(String id) async {
    _logger.info('Deleting daily income');
    await _dailyIncomeRepository.deleteDailyIncome(id).catchError((e) {
      _logger.warning('Error deleting daily income: $e');
      throw e;
    });
    _logger.info('Daily income deleted');
  }

  void dispose() {
    _dailyIncomesSubject.close();
    _logger.info('Disposed DailyIncomeService');
  }
}
