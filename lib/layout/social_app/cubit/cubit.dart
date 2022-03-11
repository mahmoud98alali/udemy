import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/models/social_app/social_user_model.dart';
import 'package:udemy/modules/social_app/chats/chats_screen.dart';
import 'package:udemy/modules/social_app/feeds/feeds_screen.dart';
import 'package:udemy/modules/social_app/settings/settings_screen.dart';
import 'package:udemy/modules/social_app/users/users_screen.dart';
import 'package:udemy/shared/components/contains.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  void getUserData() {
    emit(SocialGetUserLoadingStates());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = SocialUserModel.fromJson(value.data()!);

      emit(SocialGetUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorStates(error.toString()));
    });
  }

  int currentIndex = 0 ;

  List<Widget> screens =[
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];

  void changeBottomNav (int index)
  {
    currentIndex = index;
    emit(SocialChangeBottomNavStats());
  }
}
