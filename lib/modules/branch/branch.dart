import 'package:cloud_firestore/cloud_firestore.dart';

class Branch {
  final String id;
  final String name;

  Branch({required this.id, required this.name});

  factory Branch.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Branch(
      id: doc.id,
      name: doc['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
