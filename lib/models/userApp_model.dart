import 'package:toko_app/models/asal_model.dart';

class UserAppModel {
  AsalModel? asal;
  String? email;
  int? id;
  String? imageUrl;
  String? name;
  String? phone;
  String? status;

  UserAppModel({
    this.asal,
    this.email,
    this.id,
    this.imageUrl,
    this.name,
    this.phone,
    this.status,
  });

  UserAppModel.fromJson(Map<String, dynamic> json) {
    asal = AsalModel.fromJson(json['asal']);
    email = json['email'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    phone = json['phone'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'asal': asal!.toJson(),
      'email': email,
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'phone': phone,
      'status': status,
    };
  }
}
