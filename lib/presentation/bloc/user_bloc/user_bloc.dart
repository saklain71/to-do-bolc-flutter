import 'package:block_flutter/domain/repositories/user_repository.dart';
import 'package:block_flutter/presentation/bloc/user_bloc/user_event.dart';
import 'package:block_flutter/presentation/bloc/user_bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/src/bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final UserRepository useripository;

  UserBloc({required this.useripository}): super(UserInitial()){
    on<FetchUsers>((event, amit)async {
      emit(UserLoading());
      try{
        final users = await useripository.getUsers();
        emit(UserLoaded(users: users));
      }catch(e){
        emit(UserError(message: e.toString()));
      }
      });



  }
}