import 'package:block_flutter/data/datasources/user_api_service.dart';
import 'package:block_flutter/data/models/user_model.dart';

class UserRepository{
  final UserApiService apiservice;

  UserRepository({required this.apiservice});
  Future<List<UserModel>>  getUsers() async{
    return await apiservice.fetchUsers();
  }
}



