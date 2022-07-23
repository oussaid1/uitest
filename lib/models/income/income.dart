import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

part 'filterd_incomes.dart';
part 'income_data.dart';

class IncomeModel {
  String? id;
  String name;
  double amount;
  DateTime date;
  String source;
  int count = 1;
  IncomeModel({
    this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.source,
  });

  IncomeModel copyWith({
    String? id,
    String? name,
    double? amount,
    String? date,
    String? source,
  }) {
    return IncomeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      date: this.date,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
      'date': date,
      'source': source,
    };
  }

  factory IncomeModel.fromMap(DocumentSnapshot map) {
    return IncomeModel(
      id: map.id,
      name: map['name'],
      amount: map['amount'],
      date: map['date'].toDate(),
      source: map['source'],
    );
  }

  String toJson() => json.encode(toMap());

  factory IncomeModel.fromJson(String source) =>
      IncomeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Income(id: $id,name: $name, amount: $amount, date: $date, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IncomeModel &&
        other.name == name &&
        other.amount == amount &&
        other.date == date &&
        other.source == source;
  }

  @override
  int get hashCode {
    return name.hashCode ^ amount.hashCode ^ date.hashCode ^ source.hashCode;
  }
}
