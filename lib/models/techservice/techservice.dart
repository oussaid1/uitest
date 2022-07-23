import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models.dart';


part 'techservices_data.dart';

class TechServiceModel extends ProductModel {
  String? seviceId;
  String title;
  String? serviceDescription = 'legal only';
  DateTime createdAt = DateTime.now();
  bool? available = true;

  TechServiceModel({
    this.seviceId,
    required this.title,
    required this.createdAt,
    this.serviceDescription,
    this.available,
    String? id,
    String? name,
    String? description,
    String? category,
    DateTime? dateIn,
    DateTime? dateOut,
    int? quantity,
    double? priceIn,
    double? priceOut,
    String? suplier,
    String? availability,
  }) : super(
          pId: id,
          productName: name ?? '',
          description: description ?? '',
          category: category ?? '',
          dateIn: dateIn ?? DateTime.now(),
          quantity: quantity ?? 0,
          priceIn: priceIn ?? 0,
          priceOut: priceOut ?? 0,
          suplier: suplier ?? '',
        );

  TechServiceModel copyServiceWith({
    String? seviceId,
    String? title,
    String? serviceDescription,
    DateTime? createdAt,
    bool? available,

    // ProductModel? product,
  }) {
    return TechServiceModel(
      seviceId: seviceId ?? this.seviceId,
      title: title ?? this.title,
      serviceDescription: serviceDescription ?? this.serviceDescription,
      createdAt: createdAt ?? this.createdAt,
      available: available ?? this.available,
      //product: product ?? this.product,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      if (seviceId != null) 'serviceId': seviceId,
      'title': title,
      'description': description,
      'priceIn': priceIn,
      'priceOut': priceOut,
      'available': available,
      'timeStamp': createdAt,
    };
  }

  factory TechServiceModel.fromMap(DocumentSnapshot map) {
    return TechServiceModel(
        seviceId: map.id,
        title: map['title'],
        serviceDescription: map['description'],
        available: map['available'],
        createdAt: map['timeStamp'].toDate());
  }

  factory TechServiceModel.fromJson(String source) =>
      TechServiceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Services(id: $pId, title: $title,priceIn: $priceIn, priceOut: $priceOut, count: $count, available: $available)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TechServiceModel &&
        other.pId == pId &&
        other.title == title &&
        other.priceIn == priceIn &&
        other.priceOut == priceOut &&
        other.count == count &&
        other.available == available;
  }

  @override
  int get hashCode {
    return pId.hashCode ^
        title.hashCode ^
        priceIn.hashCode ^
        priceOut.hashCode ^
        count.hashCode ^
        available.hashCode;
  }
}
