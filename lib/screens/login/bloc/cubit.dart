import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_up/models/login_model.dart';
import 'package:shop_up/network/end_points.dart';
import 'package:shop_up/network/remote/dio_helper.dart';
import 'package:shop_up/screens/login/bloc/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  LoginModel loginModel ;
  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN, data: {'email': email, 'password': password}).then((value){
          loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }
}
