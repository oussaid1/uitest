import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

part 'filtered_payments.dart';

class PaymentModel {
  String? id;
  String clientId;
  double amount;
  DateTime date;
  String? description;
  String? clientName;
  PaymentModel({
    this.id,
    required this.clientId,
    required this.amount,
    required this.date,
    this.description,
    this.clientName,
  });

  PaymentModel copyWith({
    String? id,
    String? clientId,
    double? amount,
    DateTime? date,
    String? description,
    String? clientName,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      clientName: clientName ?? this.clientName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'amount': amount,
      'date': date,
      'description': description,
      'clientName': clientName,
    };
  }

  factory PaymentModel.fromMap(DocumentSnapshot map) {
    final Timestamp date = (map['date']);
    final payment = PaymentModel(
      id: map.id,
      clientId: map['clientId'] ?? '',
      amount: map['amount'] ?? 0.0,
      date: date.toDate(),
      description: map['description'] ?? '',
      clientName: map['clientName'] ?? '',
    );

    return payment;
  }

  String toJson() => json.encode(toMap());

  factory PaymentModel.fromJson(String source) =>
      PaymentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Payment(id: $id, clientId: $clientId, amount: $amount, date: $date, description: $description, clientName: $clientName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentModel &&
        other.id == id &&
        other.clientId == clientId &&
        other.amount == amount &&
        other.date == date &&
        other.description == description &&
        other.clientName == clientName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        clientId.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        description.hashCode ^
        clientName.hashCode;
  }

  /// fake payments
  static List<PaymentModel> get fakePayments {
    List<PaymentModel> list = [];
    for (var i = 1; i < 10; i++) {
      list.add(PaymentModel(
        clientId: i.toString(),
        amount: Random().nextInt(1000).toDouble(),
        date: DateTime.now(),
        id: i.toString(),
        clientName: 'client $i',
      ));
    }
    return list;
  }
}
