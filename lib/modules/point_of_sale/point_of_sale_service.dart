import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';
import 'point_of_sale.dart';
import 'point_of_sale_repository.dart';

class PointOfSaleService {
  final PointOfSaleRepository _pointOfSaleRepository;
  final Logger _logger = Logger('PointOfSaleService');

  final BehaviorSubject<List<PointOfSale>> _pointsOfSaleSubject =
      BehaviorSubject<List<PointOfSale>>();

  PointOfSaleService({required PointOfSaleRepository pointOfSaleRepository})
      : _pointOfSaleRepository = pointOfSaleRepository {
    _loadPointsOfSale();
  }

  Future<void> _loadPointsOfSale() async {
    _logger.info('Loading points of sale');
    _pointOfSaleRepository.getPointsOfSale().listen((pointsOfSale) {
      _pointsOfSaleSubject.add(pointsOfSale);
      _logger.info('Points of sale loaded');
    }).onError((e) {
      _logger.warning('Error loading points of sale: $e');
      throw e;
    });
  }

  Stream<List<PointOfSale>> getPointsOfSale() {
    return _pointsOfSaleSubject.stream;
  }

  Future<void> addPointOfSale(PointOfSale pointOfSale) async {
    _logger.info('Adding point of sale');
    await _pointOfSaleRepository.addPointOfSale(pointOfSale).then((_) {
      _logger.info('Point of sale added');
    }).catchError((e) {
      _logger.warning('Error adding point of sale: $e');
      throw e;
    });
  }

  Future<void> updatePointOfSale(PointOfSale pointOfSale) async {
    _logger.info('Updating point of sale');
    await _pointOfSaleRepository.updatePointOfSale(pointOfSale).then((_) {
      _logger.info('Point of sale updated');
    }).catchError((e) {
      _logger.warning('Error updating point of sale: $e');
      throw e;
    });
  }

  Future<void> deletePointOfSale(String pointOfSaleId) async {
    _logger.info('Deleting point of sale');
    await _pointOfSaleRepository.deletePointOfSale(pointOfSaleId).then((_) {
      _logger.info('Point of sale deleted');
    }).catchError((e) {
      _logger.warning('Error deleting point of sale: $e');
      throw e;
    });
  }

  void dispose() {
    _pointsOfSaleSubject.close();
    _logger.info('Disposed PointOfSaleService');
  }
}
