import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/app_formater.dart';

class DailyIncome {
  final String id;
  final DateTime date;
  final String branchId;
  final String branchName;
  final double amount;

  DailyIncome({
    this.id = '',
    required this.date,
    required this.branchId,
    required this.branchName,
    required this.amount,
  });

  factory DailyIncome.fromDocumentSnapshot(DocumentSnapshot doc) {
    return DailyIncome(
      id: doc.id,
      date: (doc['date'] as Timestamp).toDate(),
      branchId: doc['branchId'],
      branchName: doc['branchName'],
      amount: doc['amount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'branchId': branchId,
      'branchName': branchName,
      'amount': amount,
    };
  }

  String get dateFormatted => AppFormatter.date(date);
}
