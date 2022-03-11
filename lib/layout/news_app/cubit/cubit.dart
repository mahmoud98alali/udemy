
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/news_app/cubit/states.dart';
import 'package:udemy/modules/news_app/business/business_screen.dart';
import 'package:udemy/modules/news_app/science/science_screen.dart';
import 'package:udemy/modules/news_app/sports/sports_screen.dart';

import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: "Business"),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),

  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if(index==1) {
      getSport();
    }else if(index == 2){
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> sport = [];

  void getSport(){

    emit(NewsGetSportLoadingState());

    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        "country":"us",
        "category":"sport",
        "apiKey":"d3e5d9a88575490f86e6232066f0eaf8",
      },
    ).then((value){

      sport = value.data['articles'];
      print(sport[0]['title']);
      emit(NewsGetSportSuccessState());
    }).catchError((error){

      emit(NewsGetSportErrorState(error.toString()));
    });
  }

  List<dynamic> business = [];

  void getBusiness(){

    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        "country":"us",
        "category":"business",
        "apiKey":"d3e5d9a88575490f86e6232066f0eaf8",
      },
    ).then((value){

      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){

      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getScience(){

    emit(NewsGetScienceLoadingState());

    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        "country":"us",
        "category":"science",
        "apiKey":"d3e5d9a88575490f86e6232066f0eaf8",
      },
    ).then((value){

      science = value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){

      emit(NewsGetScienceErrorState(error.toString()));
    });
  }


  List<dynamic> search = [];

  void getSearch(String? value){

    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: "v2/everything",
      query: {

        "q":"$value",
        "apiKey":"d3e5d9a88575490f86e6232066f0eaf8",
      },
    ).then((value){

      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){

      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
