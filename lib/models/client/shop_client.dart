import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models.dart';

class ShopClientModel {
  String? id;
  int count = 1;
  String? clientName;
  String? phone;
  String? email;
  int stars = 1;
  List<SaleModel> sales = [];
  List<DebtModel> debts = [];
  ShopClientModel(
      {this.id, this.clientName, this.phone, this.email, this.stars = 1});
  static get client {
    return ShopClientModel(
        id: '1',
        clientName: 'Cliente',
        phone: '123456789',
        email: 'client@gmail.com');
  }

  ShopClientModel copyWith({
    String? id,
    int? count,
    String? clientName,
    String? phone,
    String? email,
    int? stars,
    List<SaleModel>? sales,
    List<DebtModel>? debts,
  }) {
    return ShopClientModel(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientName': clientName,
      'phone': phone,
      'email': email,
      'stars': stars,
    };
  }

  factory ShopClientModel.fromMap(DocumentSnapshot map) {
    return ShopClientModel(
        id: map.id,
        clientName: map['clientName'],
        phone: map['phone'],
        email: map['email'],
        stars: map['stars']);
  }

  String toJson() => json.encode(toMap());

  factory ShopClientModel.fromJson(String source) =>
      ShopClientModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Client(id: $id, count: $count, clientName: $clientName, phone: $phone, email: $email, stars: $stars, sales: $sales, debts: $debts)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShopClientModel &&
        other.id == id &&
        other.count == count &&
        other.clientName == clientName &&
        other.phone == phone &&
        other.email == email &&
        other.stars == stars &&
        listEquals(other.sales, sales) &&
        listEquals(other.debts, debts);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        count.hashCode ^
        clientName.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        stars.hashCode ^
        sales.hashCode ^
        debts.hashCode;
  }

  /// list of fake clients
  static List<ShopClientModel> get fakeClients {
    List<ShopClientModel> list = [];
    for (var i = 0; i < 10; i++) {
      list.add(ShopClientModel(
        id: '$i',
        clientName: 'Cliente $i',
        phone: '123456789',
        email: '',
        stars: 1,
      ));
    }
    return list;
  }
}
