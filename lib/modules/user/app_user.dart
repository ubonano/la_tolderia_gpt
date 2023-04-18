import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String email;
  final String displayName;
  final String password;

  AppUser({
    required this.uid,
    required this.email,
    required this.displayName,
    this.password = '',
  });

  // Método para convertir un DocumentSnapshot en un objeto AppUser
  factory AppUser.fromDocumentSnapshot(DocumentSnapshot doc) {
    return AppUser(
      uid: doc.id,
      email: doc['email'],
      displayName: doc['displayName'],
    );
  }

  // Método para convertir un objeto AppUser en un Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
    };
  }
}
