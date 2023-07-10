import 'package:cubit_fetch_api/cubit/user_cubit.dart';
import 'package:cubit_fetch_api/cubit/user_cubit_state.dart';
import 'package:cubit_fetch_api/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserCubit(apiService: ApiService()))
        ],
        child: MaterialApp(
          title: 'Cubit',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Cubit Fetch API'),
          debugShowCheckedModeBanner: false,
        )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserCubit>().getAllUserList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: BlocBuilder<UserCubit, UserCubitState>(
        builder: (context, state){
          if(state is UserCubitLoading){
            return const Center(child: CircularProgressIndicator(),);
          }else if(state is UserCubitError) {
            return Center(child: Text(state.message.toString()),);
          }else if(state is UserCubitDataLoaded){
            return ListView.builder(
                itemBuilder: (context, itemIndex){
                  UserModel userModel = state.userList[itemIndex];
                  return ListTile(
                    leading: Text(userModel.id.toString()),
                    title: Text(userModel.name.toString()),
                    subtitle: Text(userModel.email.toString()),
                  );
                },
              itemCount: state.userList.length,
            );
          }else{
            return SizedBox();
          }
        }
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
