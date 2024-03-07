import 'package:cloud_firestore/cloud_firestore.dart';

SessionsModel? sessionsModel;
class SessionsModel{
  String deviceId;
  DateTime lastLoggin;

  SessionsModel({
    required this.deviceId,
    required this.lastLoggin,
    });

  SessionsModel copyWith({
    
    String? session,
    DateTime? lastLoggin,
    DocumentReference? reference,
  }){
    return SessionsModel(
      deviceId: session??this.deviceId,
      lastLoggin: lastLoggin??this.lastLoggin,
       );
  }

  Map<String,dynamic>toJson(){
    final Map<String,dynamic>data=<String, dynamic>{};
    data['deviceId']=deviceId??'';
    data['lastLoggin']=lastLoggin??DateTime.now();
  return data;
  }

  factory SessionsModel.fromJson(Map<String,dynamic>map){
    return SessionsModel(
      deviceId: map['deviceId'],
     lastLoggin: map['lastLoggin'].toDate(),
      );
  }


}