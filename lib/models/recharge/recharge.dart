// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum RechargeOperator {
  orange,
  inwi,
  iam,
}

class RechargeModel {
  String? id;
  RechargeOperator oprtr;
  double percntg;
  double amount;
  num qntt;
  DateTime date;
  String? suplyrID;

  RechargeModel({
    this.id,
    required this.oprtr,
    required this.percntg,
    required this.amount,
    required this.qntt,
    required this.date,
    this.suplyrID,
  });

  RechargeModel copyWith({
    String? id,
    RechargeOperator? oprtr,
    double? percntg,
    double? amount,
    num? qntt,
    DateTime? date,
    String? suplyrID,
  }) {
    return RechargeModel(
      id: id ?? this.id,
      oprtr: oprtr ?? this.oprtr,
      percntg: percntg ?? this.percntg,
      amount: amount ?? this.amount,
      qntt: qntt ?? this.qntt,
      date: date ?? this.date,
      suplyrID: suplyrID ?? this.suplyrID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'oprtr': oprtr.toString(),
      'percntg': percntg,
      'amount': amount,
      'qnt': qntt,
      'date': date,
      'suplyrID': suplyrID,
    };
  }

  factory RechargeModel.fromMap(Map<String, dynamic> map) {
    return RechargeModel(
      id: map['id'],
      oprtr: map['oprtr'],
      percntg: map['percntg'] as double,
      amount: map['amount'] as double,
      qntt: map['qnt'] as num,
      date: map['date'] as DateTime,
      suplyrID: map['suplyrID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RechargeModel.fromJson(String source) =>
      RechargeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RachargeModel(id: $id, oprtr: $oprtr, percntg: $percntg, amount: $amount, qnt: $qntt, date: $date, suplyrID: $suplyrID)';
  }

  /// a list  of fake data to be used for testing
  static List<RechargeModel> get fakeData => [
        RechargeModel(
          id: '1',
          oprtr: RechargeOperator.orange,
          percntg: 10,
          amount: 10,
          qntt: 1,
          date: DateTime.now(),
          suplyrID: '1',
        ),
        RechargeModel(
          id: '2',
          oprtr: RechargeOperator.inwi,
          percntg: 7,
          amount: 20,
          qntt: 2,
          date: DateTime(2020, 1, 1),
          suplyrID: '2',
        ),
        RechargeModel(
          id: '3',
          oprtr: RechargeOperator.iam,
          percntg: 30,
          amount: 30,
          qntt: 3,
          date: DateTime.now(),
          suplyrID: '3',
        ),
      ];

  /// get color acording to the operator
  Color get color {
    switch (oprtr) {
      case RechargeOperator.orange:
        return orange;
      case RechargeOperator.inwi:
        return inwi;
      case RechargeOperator.iam:
        return iam;
    }
  }

  static Color getOprtrColor(RechargeOperator oprtr) {
    switch (oprtr) {
      case RechargeOperator.orange:
        return orange;
      case RechargeOperator.inwi:
        return inwi;
      case RechargeOperator.iam:
        return iam;
    }
  }

  static const Color orange = Colors.orange;
  static const Color inwi = Colors.purple;
  static const Color iam = Colors.blue;
}

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
class RechargeSale extends RechargeModel {
  String? rSId;
  num qnttSld;
  DateTime dateSld;
  String? clntID;
  String? soldRchrgId;
  RechargeSale({
    this.clntID,
    this.rSId,
    required this.qnttSld,
    required this.soldRchrgId,
    required this.dateSld,
    RechargeModel? rchgMdl,
  }) : super(
          id: rchgMdl?.id,
          oprtr: rchgMdl?.oprtr ?? RechargeOperator.orange,
          percntg: rchgMdl?.percntg ?? 0.0,
          amount: rchgMdl?.amount ?? 0.0,
          qntt: rchgMdl?.qntt ?? 0,
          date: rchgMdl?.date ?? DateTime.now(),
          suplyrID: rchgMdl?.suplyrID,
        );

  RechargeSale copyRSWith({
    String? clntID,
    String? rSId,
    String? soldRchrgId,
    num? qnttSld,
    DateTime? dateSld,
    RechargeModel? rchgMdl,
  }) {
    return RechargeSale(
      clntID: clntID ?? this.clntID,
      rSId: rSId ?? this.rSId,
      soldRchrgId: soldRchrgId ?? this.soldRchrgId,
      qnttSld: qnttSld ?? this.qnttSld,
      dateSld: dateSld ?? this.dateSld,
    );
  }

  @override

  /// toMap()
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (rSId != null) 'rSId': rSId,
      'qnttSld': qnttSld,
      'dateSld': dateSld,
      'clntID': clntID,
      'soldRchrgId': soldRchrgId,
    };
  }

  @override
  RechargeModel copyWith({
    String? id,
    RechargeOperator? oprtr,
    double? percntg,
    double? amount,
    num? qntt,
    DateTime? date,
    String? suplyrID,
  }) {
    return RechargeModel(
      id: id ?? this.id,
      oprtr: oprtr ?? this.oprtr,
      percntg: percntg ?? this.percntg,
      amount: amount ?? this.amount,
      qntt: qntt ?? this.qntt,
      date: date ?? this.date,
      suplyrID: suplyrID ?? this.suplyrID,
    );
  }

  factory RechargeSale.fromDocument(DocumentSnapshot map) {
    return RechargeSale(
      clntID: map['clntID'],
      soldRchrgId: map['soldRchrgId'],
      rSId: map['rchgSlId'],
      qnttSld: map['qnttSld'] as num,
      dateSld: map['dateSld'] as DateTime,
    );
  }

  /// fromMap()
  factory RechargeSale.fromMap(Map<String, dynamic> map) {
    return RechargeSale(
      clntID: map['clntID'],
      soldRchrgId: map['soldRchrgId'],
      rSId: map['rchgSlId'],
      qnttSld: map['qnttSld'] as num,
      dateSld: map['dateSld'] as DateTime,
    );
  }

  @override
  String toJson() => json.encode(toMap());
  factory RechargeSale.fromJson(String source) =>
      RechargeSale.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  String toString() {
    return 'RechargeSale(clntID: $clntID, rchgSlId: $rSId, qnttSld: $qnttSld, dateSld: $dateSld)';
  }

  /// fake data to be used for testing
  static List<RechargeSale> get fakeData => [
        RechargeSale(
          clntID: '1',
          soldRchrgId: '1',
          rSId: '1',
          qnttSld: 1,
          dateSld: DateTime.now(),
        ),
        RechargeSale(
          clntID: '2',
          soldRchrgId: '2',
          rSId: '2',
          qnttSld: 2,
          dateSld: DateTime.now(),
        ),
        RechargeSale(
          clntID: '3',
          soldRchrgId: '3',
          rSId: '3',
          qnttSld: 3,
          dateSld: DateTime.now(),
        ),
      ];
}
