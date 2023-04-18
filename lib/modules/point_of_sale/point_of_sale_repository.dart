import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';
import 'point_of_sale.dart';

class PointOfSaleRepository {
  final FirebaseFirestore _firebaseFirestore;
  final Logger _logger = Logger('PointOfSaleRepository');

  PointOfSaleRepository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  CollectionReference<Map<String, dynamic>> get _pointsOfSaleCollection =>
      _firebaseFirestore.collection('pointsOfSale');

  Stream<List<PointOfSale>> getPointsOfSale() {
    _logger.info('Getting points of sale');
    return _pointsOfSaleCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => PointOfSale.fromDocumentSnapshot(doc))
          .toList();
    }).handleError((e) {
      _logger.warning('Error getting points of sale: $e');
      throw e;
    });
  }

  Future<void> addPointOfSale(PointOfSale pointOfSale) {
    _logger.info('Adding point of sale');
    return _pointsOfSaleCollection.add(pointOfSale.toMap()).catchError((e) {
      _logger.warning('Error adding point of sale: $e');
      throw e;
    }).then((_) => _logger.info('Point of sale added'));
  }

  Future<void> updatePointOfSale(PointOfSale pointOfSale) {
    _logger.info('Updating point of sale');
    return _pointsOfSaleCollection
        .doc(pointOfSale.id)
        .update(pointOfSale.toMap())
        .catchError((e) {
      _logger.warning('Error updating point of sale: $e');
      throw e;
    }).then((_) => _logger.info('Point of sale updated'));
  }

  Future<void> deletePointOfSale(String pointOfSaleId) {
    _logger.info('Deleting point of sale');
    return _pointsOfSaleCollection.doc(pointOfSaleId).delete().catchError((e) {
      _logger.warning('Error deleting point of sale: $e');
      throw e;
    }).then((_) => _logger.info('Point of sale deleted'));
  }
}
