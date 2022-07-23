import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  String? id;
  String? name;
  String? email;
  String? token;
  String? photoUrl;
  String? phoneNumber;
  DateTime? createdAt;
  DateTime? updatedAt;

  /// empty
  static final UserModel empty = UserModel(
    id: 'empty',
    name: 'empty',
    email: 'empty',
    token: '',
    photoUrl: '',
    phoneNumber: '',
    createdAt: null,
    updatedAt: null,
  );
  UserModel(
      {this.id,
      this.name,
      this.email,
      this.token,
      this.photoUrl,
      this.phoneNumber,
      this.createdAt,
      this.updatedAt});

  /// copyWith
  UserModel copyWith(
      {String? id,
      String? name,
      String? email,
      String? token,
      String? photoUrl,
      String? phoneNumber,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'token': token,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
  //   id = documentSnapshot.id;
  //   name = documentSnapshot['name'];
  //   email = documentSnapshot['email'];
  //   token = documentSnapshot['token'];
  //   photoUrl = documentSnapshot['photoUrl'];
  //   phoneNumber = documentSnapshot['phoneNumber'];
  //   createdAt = documentSnapshot['createdAt'];
  //   updatedAt = documentSnapshot['updatedAt'];
  // }
  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    // log("UserModel.fromDocumentSnapshot");
    //log('${documentSnapshot.toString()}');
    Timestamp timestamp = documentSnapshot["createdAt"] ?? Timestamp.now();
    Timestamp timestamp2 = documentSnapshot["updatedAt"] ?? Timestamp.now();

    createdAt = timestamp.toDate();
    updatedAt = timestamp2.toDate();
    id = documentSnapshot.id;
    name = documentSnapshot["name"] ?? '';
    email = documentSnapshot["email"] ?? '';
    token = documentSnapshot["token"] ?? '';
    photoUrl = documentSnapshot["photoUrl"] ?? '';
    phoneNumber = documentSnapshot["phoneNumber"] ?? '';
  }
  UserModel.fromUserCredential(User user)
      : id = user.uid,
        name = user.displayName,
        email = user.email,
        token = '',
        photoUrl = '',
        phoneNumber = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  UserModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    email = map["email"];
    token = map["token"];
    photoUrl = map["photoUrl"];
    phoneNumber = map["phoneNumber"];
    createdAt = map["createdAt"].toDate();
    updatedAt = map["updatedAt"].toDate();
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, token: $token, photoUrl: $photoUrl, phoneNumber: $phoneNumber, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          token == other.token &&
          photoUrl == other.photoUrl &&
          phoneNumber == other.phoneNumber &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      token.hashCode ^
      photoUrl.hashCode ^
      phoneNumber.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  // /// empty user
  // static UserModel empty() => UserModel(
  //       id: null,
  //       name: null,
  //       email: null,
  //       token: null,
  //       photoUrl: "",
  //       phoneNumber: null,
  //       createdAt: null,
  //       updatedAt: null,
  //     );

  @override
  List<Object> get props => [
        id!,
        name!,
        email!,
        token!,
        photoUrl!,
        phoneNumber!,
        createdAt!,
        updatedAt!
      ];
}
