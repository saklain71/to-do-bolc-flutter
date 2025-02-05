import 'package:block_flutter/domain/entities/user_entity.dart';

abstract class UserState{}

class UserInitial extends UserState{}

class UserLoading extends UserState{}

class UserLoaded extends UserState {
  final List<UserEntity> users;
  UserLoaded({required this.users});
}

class UserError extends UserState{
  final String message;
  UserError({required this.message});
}