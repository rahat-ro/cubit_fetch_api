import 'package:cubit_fetch_api/cubit/user_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api_service.dart';
import '../model/user_model.dart';

class UserCubit extends Cubit<UserCubitState>{

  List<UserModel> userList = [];
  ApiService apiService;

  UserCubit({required this.apiService}): super(UserCubitInit());

  void getAllUserList() async{
    try{
      emit(UserCubitLoading());
      userList = await apiService.getData();
      emit(UserCubitDataLoaded(userList: userList));
    } catch(e){
      emit(UserCubitError(message: e.toString()));
    }

  }

}