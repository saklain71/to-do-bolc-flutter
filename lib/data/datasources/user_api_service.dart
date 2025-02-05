import 'dart:convert';

import 'package:block_flutter/data/models/user_model.dart';
import 'package:http/http.dart' as http;


class UserApiService{
  final String apiUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<UserModel>> fetchUsers() async{
    final response = await http.get(Uri.parse(apiUrl));
    if(response .statusCode == 200){
      List<dynamic> jsonData = json.decode(response.body);
      print(jsonData);
      return jsonData.map((user) => UserModel.fromjson(user)).toList();
    }else{
      throw Exception('Failes to load users');
    }
  }
}