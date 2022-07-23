import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models.dart';
import '../payment/payment.dart';
part 'debt_data.dart';
part 'filtered_debts.dart';

class DebtModel {
  String? id;
  String? productName;
  String? clientName;
  String? clientId;
  String? type; // product or service
  DateTime timeStamp = DateTime.now();
  double amount;
  double paidAmount;
  DateTime deadLine = DateTime.now();

  /// get total amount of debt left to pay
  double get totalAmountLeft => amount - paidAmount;

  /// get is fully paid
  bool get isFullyPaid => totalAmountLeft == 0;
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
    this.productName,
    this.clientId,
    this.type,
    this.clientName,
    required this.amount,
    required this.paidAmount,
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
      productName: productName ?? this.productName,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      paidAmount: paidAmount ?? this.paidAmount,
      timeStamp: timeStamp,
      deadLine: deadLine,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'clientId': clientId,
      'clientName': clientName,
      'type': type,
      'amount': amount,
      'paid': paidAmount,
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
      productName: map['productName'] ?? '',
      clientId: map['clientId'] ?? '',
      clientName: map['clientName'] ?? '',
      type: map['type'] ?? '',
      amount: map['amount'] ?? 0,
      paidAmount: map['paid'] ?? 0,
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
    return 'Debt(id: $id, productName: $productName,clientId:$clientId, clientName:$clientName , type: $type, amount: $amount, paid: $paidAmount, dueDate:$deadLine,timeStamp:$timeStamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DebtModel &&
        other.id == id &&
        other.productName == productName &&
        other.clientId == clientId &&
        other.clientName == clientName &&
        other.type == type &&
        other.amount == amount &&
        other.deadLine == deadLine &&
        other.timeStamp == timeStamp &&
        other.paidAmount == paidAmount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productName.hashCode ^
        clientId.hashCode ^
        clientName.hashCode ^
        type.hashCode ^
        amount.hashCode ^
        paidAmount.hashCode ^
        deadLine.hashCode ^
        timeStamp.hashCode;
  }

  /// fake debts
  static List<DebtModel> getFakeDebts() {
    List<DebtModel> debts = [];
    for (var i = 0; i < 10; i++) {
      debts.add(
        DebtModel(
          id: '1',
          productName: 'product $i',
          clientId: '$i',
          clientName: 'client $i',
          type: 'product',
          amount: 100,
          paidAmount: 0,
          timeStamp: DateTime.now()..add(Duration(days: -i)),
          deadLine: DateTime.now().add(const Duration(days: 30)),
        ),
      );
    }
    return debts;
  }
}
