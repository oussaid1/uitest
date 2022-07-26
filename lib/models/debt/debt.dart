import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uitest/extentions.dart';
import '../models.dart';
part 'debt_data.dart';
part 'filtered_debts.dart';

enum DebtFilter {
  all,
  overdue,
  today,
  thisWeek,
  thisMonth,
  thisYear,
}

class DebtModel {
  String? id;
  String? clientId;
  DateTime timeStamp = DateTime.now();
  double amount;
  //double paidAmount;
  DateTime deadLine = DateTime.now();

  /// get total amount of debt left to pay
  //double get totalAmountLeft => amount - paidAmount;

  /// get is fully paid
  // bool get isFullyPaid => totalAmountLeft == 0;
  // get howmany days after deadline
  int get daysOverdue {
    return DateTime.now().difference(deadLine).inDays;
  }

  // get is overdue
  bool get isOverdue {
    return DateTime.now().isAfter(deadLine);
  }

  DebtModel({
    this.id,
    this.clientId,
    required this.amount,
    required this.timeStamp,
    required this.deadLine,
  });

  DebtModel copyWith({
    String? id,
    String? clientName,
    String? clientId,
    String? productName,
    String? type,
    double? amount,
    double? paidAmount,
    int? count,
  }) {
    return DebtModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      amount: amount ?? this.amount,
      timeStamp: timeStamp,
      deadLine: deadLine,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'amount': amount,
      'dueDate': deadLine,
      'timeStamp': timeStamp
    };
  }

  factory DebtModel.fromMap(DocumentSnapshot map) {
    Timestamp timeStamp = map['timeStamp'];
    Timestamp dueDatem = map['dueDate'];
    var date = timeStamp.toDate();
    var dueDate = (dueDatem.toDate());
    DebtModel debt = DebtModel(
      id: map.id,
      clientId: map['clientId'] ?? '',
      amount: map['amount'] ?? 0,
      timeStamp: date,
      deadLine: dueDate,
    );

    return debt;
  }

  String toJson() => json.encode(toMap());

  factory DebtModel.fromJson(String source) =>
      DebtModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DebtModel(id: $id, clientId: $clientId, amount: $amount, timeStamp: $timeStamp, deadLine: $deadLine)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DebtModel &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        clientId == other.clientId &&
        amount == other.amount &&
        timeStamp == other.timeStamp &&
        deadLine == other.deadLine;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        clientId.hashCode ^
        amount.hashCode ^
        timeStamp.hashCode ^
        deadLine.hashCode;
  }

  /// fake debts
  static List<DebtModel> get fakeDebts {
    List<DebtModel> debts = [];
    for (var i = 0; i < 10; i++) {
      debts.add(
        DebtModel(
          id: '1',
          clientId: '$i',
          amount: Random().nextInt(100000).toDouble(),
          timeStamp: DateTime.now()..add(Duration(days: -i)),
          deadLine: DateTime.now().add(const Duration(days: 30)),
        ),
      );
    }
    return debts;
  }
}
