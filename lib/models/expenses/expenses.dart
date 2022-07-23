import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

part 'expenses_data.dart';
part 'filered_expenses.dart';

enum ExpenseCategory { electricity, water, internet, telephone, rent, other }

class ExpenseModel {
  String? id;
  String name;
  DateTime date;
  DateTime deadLine;
  double amount;
  double amountPaid;
  ExpenseCategory expenseCategory;
  bool get isPaid => amountPaid == amount;
  ExpenseModel({
    this.id,
    required this.name,
    required this.date,
    required this.deadLine,
    required this.amount,
    required this.amountPaid,
    required this.expenseCategory,
  });

  ExpenseModel copyWith({
    String? id,
    String? name,
    DateTime? timeStamp,
    DateTime? deadLine,
    double? amount,
    double? amountPaid,
    bool? isPaid,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      date: timeStamp ?? date,
      deadLine: deadLine ?? this.deadLine,
      amount: amount ?? this.amount,
      amountPaid: amountPaid ?? this.amountPaid,
      expenseCategory: expenseCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'timeStamp': date,
      'deadLine': deadLine,
      'amount': amount,
      'amountPaid': amountPaid,
      'expenseCategory': expenseCategory.name,
    };
  }

  factory ExpenseModel.fromMap(DocumentSnapshot map) {
    return ExpenseModel(
      id: map.id,
      name: map['name'],
      date: map['timeStamp'].toDate(),
      deadLine: map['deadLine'].toDate(),
      amount: map['amount'],
      amountPaid: map['amountPaid'],
      expenseCategory: map['expenseCategory'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Expense(id: $id, name: $name, timeStamp: $date, deadLine: $deadLine, amount: $amount, amountPaid: $amountPaid, isPaid: $isPaid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseModel &&
        other.id == id &&
        other.name == name &&
        other.date == date &&
        other.deadLine == deadLine &&
        other.amount == amount &&
        other.amountPaid == amountPaid &&
        other.isPaid == isPaid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        date.hashCode ^
        deadLine.hashCode ^
        amount.hashCode ^
        amountPaid.hashCode ^
        isPaid.hashCode;
  }
}
