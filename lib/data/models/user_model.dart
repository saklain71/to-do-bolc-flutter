import 'package:block_flutter/domain/entities/user_entity.dart';

class UserModel extends UserEntity{

  UserModel({
    required int id,
    required String name,
    required String username,
    required String email,
    required Address address,
    required String phone,
    required String website,
    required Company company,

  }) : super(
    id: id,
    name: name,
    username: username,
    email: email,
    address: address,
    phone: phone,
    website: website,
    company: company,
  );

  factory UserModel.fromjson(Map<String,dynamic> json){
    return UserModel(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        address: Address.fromJson(json['address']),
        phone: json['phone'],
        website: json['website'],
        company: Company.fromJson(json['company']),
    );
  }

}