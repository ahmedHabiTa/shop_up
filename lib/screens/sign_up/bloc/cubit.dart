import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_up/models/login_model.dart';
import 'package:shop_up/network/end_points.dart';
import 'package:shop_up/network/remote/dio_helper.dart';

import 'package:shop_up/screens/sign_up/bloc/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  LoginModel loginModel ;
  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER, data: {'name' : name,'email': email,'phone' : phone, 'password': password,}).then((value){
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }
}
