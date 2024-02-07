import 'package:cloud_firestore/cloud_firestore.dart';

UserModel? userModel;

class UserModel {
  String? id;
  DocumentReference? ref;
 String name;
 String phoneNumber;
 String email;

  UserModel(
      {
       required this.name,
       required this.phoneNumber,
       required this.email,
        this.id,
this.ref,
      });

  UserModel copyWith({
    String? name,
    String? phoneNumber,
    String? id,
    DocumentReference? reference,
    String? email,
  }) {
    return UserModel(
      name: name??this.name,
      phoneNumber: phoneNumber??this.phoneNumber,
      id: id??this.id,
      ref: reference??this.ref,
      email: email??this.email,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name ?? "";
    data['phoneNumber'] = phoneNumber ??'';
    data['id']=id??'';
    data['ref']=ref;
    data['email']=email;
    return data;
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
    name: map['name'],
      phoneNumber: map['phoneNumber'],
      id: map['id'],
      ref: map['ref'],
      email: map['email'],
    );
  }
}

