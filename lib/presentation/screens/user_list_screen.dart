import 'package:block_flutter/data/datasources/user_api_service.dart';
import 'package:block_flutter/domain/repositories/user_repository.dart';
import 'package:block_flutter/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:block_flutter/presentation/bloc/user_bloc/user_event.dart';
import 'package:block_flutter/presentation/bloc/user_bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// class UserListScreen extends StatelessWidget {
//   const UserListScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context)=> UserBloc(
//             userripository: UserRepository(apiservice: UserApiService())
//         )..add(FetchUsers()),
//       child: Scaffold(
//         appBar: AppBar(title: Text('Users')),
//         body: BlocBuilder<UserBloc, UserState>(
//             builder:(context, state){
//               if(state is UserLoading){
//                 return Center(child: CircularProgressIndicator(),);
//               }else if(state is UserLoaded){
//                 return ListView.builder(
//                   itemCount: state.users.length,
//                   itemBuilder: (context, index){
//                     final user = state.users[index];
//                     return ListTile(
//                       title: Text(user.name.toString()),
//                       subtitle: Text(user.email.toString()),
//                       leading: CircleAvatar(child: Text(user.name[0])),
//                     );
//                   },
//                 );
//               }
//               return Center(
//                 child: ElevatedButton(
//                     onPressed: (){
//                       BlocProvider.of<UserBloc>(context).add(FetchUsers());
//                     },
//                     child: Text("Load User")),
//               );
//             }),
//       ),
//     );
//   }
// }


class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        // userRepository: UserRepository(apiService: UserApiService()),
          useripository: UserRepository(apiservice: UserApiService())
      )..add(FetchUsers()), // 🔹 API call triggered here
      child: Scaffold(
        backgroundColor: Colors.tealAccent,
        appBar: AppBar(title: Text('Users')),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  );
                },
              );
            } else if (state is UserError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Center(child: Text('No data available.'));
          },
        ),
      ),
    );
  }
}
