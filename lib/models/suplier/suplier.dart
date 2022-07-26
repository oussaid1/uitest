import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class SuplierModel {
  String? id;
  String? name;
  String? phone;
  String? email;
  GeoPoint? location;

  SuplierModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.location,
  });
  static const laayoune = GeoPoint(27.148650226484776, -13.197234277282037);
  SuplierModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    GeoPoint? location,
    String? productType,
  }) {
    return SuplierModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'location': {
        location!.latitude.toString(),
        location!.longitude.toString()
      },
    };
  }

  factory SuplierModel.fromMap(DocumentSnapshot map) {
    // var x = double.parse(map['location'][0] as String);
    // var y = double.parse(map['location'][1] as String);

    return SuplierModel(
      id: map.id,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      location: laayoune,
    );
  }

  String toJson() => json.encode(toMap());

  factory SuplierModel.fromJson(String source) =>
      SuplierModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Suplier(id: $id, name: $name, phone: $phone, email: $email, location: $location,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SuplierModel &&
        other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.location == location;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        location.hashCode;
  }

  /// fake data
  static List<SuplierModel> fakeData = [
    SuplierModel(
      id: '1',
      name: 'Suplier 1',
      phone: '0123456789',
      email: ' @gmail.com',
      location: laayoune,
    ),
    SuplierModel(
      id: '2',
      name: 'Suplier 2',
      phone: '0123456789',
      email: ' @gmail.com',
      location: laayoune,
    ),
    SuplierModel(
      id: '3',
      name: 'Suplier 3',
      phone: '0123456789',
      email: ' @gmail.com',
      location: laayoune,
    ),
    SuplierModel(
      id: '4',
      name: 'Suplier 4',
      phone: '0123456789',
      email: ' @gmail.com',
      location: laayoune,
    ),
  ];
}
