import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/models/social_app/social_user_model.dart';
import 'package:udemy/modules/social_app/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      userCreate(
        email: email,
        phone: phone,
        name: name,
        uId: value.user!.uid,
      );

    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
      print(error.toString());
    });
  }

  void userCreate({
    required String email,
    required String phone,
    required String name,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      bio: 'write you bio ...',
      image:'https://img.freepik.com/free-photo/happy-bearded-male-blogger-rejoices-having-new-followers-blog_273609-36886.jpg?w=826',
      cover:'https://img.freepik.com/free-vector/realistic-three-dimensional-ramadan-kareem-illustration_52683-57837.jpg?size=626&ext=jpg&ga=GA1.1.841245234.1648047409',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void ChangePasswordVisibility() {
    isPassword = !isPassword;
    if (isPassword) {
      suffix = Icons.visibility_outlined;
    } else {
      suffix = Icons.visibility_off_outlined;
    }
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
