import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

import 'branch.dart';

class BranchRepository {
  final FirebaseFirestore _firebaseFirestore;
  final Logger _logger = Logger('BranchRepository');

  BranchRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  CollectionReference get _branchsCollection =>
      _firebaseFirestore.collection('branches');

  Stream<List<Branch>> getBranches() {
    _logger.info('Fetching branches');

    return _branchsCollection.snapshots().map((snapshot) {
      try {
        _logger.info('Fetched branches successfully');

        return snapshot.docs
            .map((doc) => Branch.fromDocumentSnapshot(doc))
            .toList();
      } catch (e, stackTrace) {
        _logger.severe('Failed to fetch branches', e, stackTrace);
        return [];
      }
    });
  }

  Future<void> addBranch(Branch branch) async {
    try {
      _logger.info('Adding branch');

      await _branchsCollection.add(branch.toMap());

      _logger.info('Added branch successfully');
    } catch (e, stackTrace) {
      _logger.severe('Failed to add branch', e, stackTrace);
      rethrow;
    }
  }

  Future<void> updateBranch(Branch branch) async {
    try {
      _logger.info('Updating branch');

      await _branchsCollection.doc(branch.id).update(branch.toMap());

      _logger.info('Updated branch successfully');
    } catch (e, stackTrace) {
      _logger.severe('Failed to update branch', e, stackTrace);
      rethrow;
    }
  }

  Future<void> deleteBranch(String branchId) async {
    try {
      _logger.info('Deleting branch');

      await _branchsCollection.doc(branchId).delete();

      _logger.info('Deleted branch successfully');
    } catch (e, stackTrace) {
      _logger.severe('Failed to delete branch', e, stackTrace);
      rethrow;
    }
  }
}
