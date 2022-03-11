import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/modules/shop_app/login_screen/cubit/states.dart';
import 'package:udemy/shared/network/remote/dio_helper.dart';
import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {

      loginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true ;
  void ChangePasswordVisibility(){
    isPassword=!isPassword;
    if(isPassword){
      suffix = Icons.visibility_outlined ;
    }else{
      suffix = Icons.visibility_off_outlined;
    }
    emit(ShopChangePasswordVisibilityState());
  }


}
