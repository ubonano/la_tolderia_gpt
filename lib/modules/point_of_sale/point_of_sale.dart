import 'package:cloud_firestore/cloud_firestore.dart';

class PointOfSale {
  final String id;
  final String name;
  final String branchId;
  final String branchName;

  PointOfSale(
      {required this.id,
      required this.name,
      required this.branchId,
      required this.branchName});

  factory PointOfSale.fromDocumentSnapshot(DocumentSnapshot doc) {
    return PointOfSale(
        id: doc.id,
        name: doc['name'],
        branchId: doc['branchId'],
        branchName: doc['branchName']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'branchId': branchId,
      'branchName': branchName,
    };
  }
}
