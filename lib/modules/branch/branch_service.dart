import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import 'branch.dart';
import 'branch_repository.dart';

class BranchService {
  final BranchRepository _branchRepository;
  final Logger _logger = Logger('BranchService');

  final BehaviorSubject<List<Branch>> _branchesSubject =
      BehaviorSubject<List<Branch>>();

  BranchService({required BranchRepository branchRepository})
      : _branchRepository = branchRepository {
    _loadBranches();
  }

  Future<void> _loadBranches() async {
    _logger.info('Loading branches');

    _branchRepository.getBranches().listen((branches) {
      _branchesSubject.add(branches);

      _logger.info('Loaded branches');
    }, onError: (e, stackTrace) {
      _logger.severe('Failed to load branches', e, stackTrace);
    });
  }

  Stream<List<Branch>> getBranches() {
    return _branchesSubject.stream;
  }

  Future<void> addBranch(Branch branch) async {
    try {
      _logger.info('Adding branch in service');

      await _branchRepository.addBranch(branch);

      _logger.info('Added branch in service');
    } catch (e, stackTrace) {
      _logger.severe('Failed to add branch in service', e, stackTrace);
      rethrow;
    }
  }

  Future<void> updateBranch(Branch branch) async {
    try {
      _logger.info('Updating branch in service');

      await _branchRepository.updateBranch(branch);

      _logger.info('Updated branch in service');
    } catch (e, stackTrace) {
      _logger.severe('Failed to update branch in service', e, stackTrace);
      rethrow;
    }
  }

  Future<void> deleteBranch(String branchId) async {
    try {
      _logger.info('Deleting branch in service');

      await _branchRepository.deleteBranch(branchId);

      _logger.info('Deleted branch in service');
    } catch (e, stackTrace) {
      _logger.severe('Failed to delete branch in service', e, stackTrace);
      rethrow;
    }
  }

  void dispose() {
    _branchesSubject.close();
    _logger.info('Disposed BranchService');
  }
}
