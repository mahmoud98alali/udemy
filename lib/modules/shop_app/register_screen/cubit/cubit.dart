import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/modules/shop_app/register_screen/cubit/states.dart';
import 'package:udemy/shared/network/end_points.dart';
import 'package:udemy/shared/network/remote/dio_helper.dart';
import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/components/contains.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {

      loginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(loginModel));

    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));

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
    emit(ShopRegisterChangePasswordVisibilityState());
  }


}

