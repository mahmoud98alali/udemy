
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/shop_app/shop_layout/cubit/states.dart';
import 'package:udemy/models/shop_app/categories_model.dart';
import 'package:udemy/models/shop_app/favorites_model.dart';
import 'package:udemy/models/shop_app/home_model.dart';
import 'package:udemy/models/shop_app/login_model.dart';
import 'package:udemy/modules/shop_app/categories/categories_screen.dart';
import 'package:udemy/modules/shop_app/favorites/favorites_screen.dart';
import 'package:udemy/modules/shop_app/products/products_screen.dart';
import 'package:udemy/modules/shop_app/settings/settings_screen.dart';
import 'package:udemy/shared/components/contains.dart';
import 'package:udemy/shared/network/end_points.dart';
import 'package:udemy/shared/network/remote/dio_helper.dart';

import '../../../../models/shop_app/change_favorites.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index){
    currentIndex = index ;
    emit(ShopChangeBottomNavState());
  }

   HomeModel? homeModel;


  Map<int,bool>? favorites = {};
  void getHomeData(){
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      // printFullText(homeModel?.data!.banners[0].image);
      // print(token);
      // printFullText(homeModel!.data!.banners[0].image);

      homeModel!.data!.products.forEach((element) {
        favorites!.addAll({
          element.id! : element.inFavorites! ,

        });
      });

      // print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error){

      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavoritesData(int productId){

    favorites![productId] =!favorites![productId]!;

    emit(ShopSuccessFavoritesDataState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value)
    {
      changeFavoritesModel =ChangeFavoritesModel.fromJson(value.data);
      // print(value.data);

      if(!changeFavoritesModel!.status!){
         favorites![productId] =!favorites![productId]!;

      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoriteState(changeFavoritesModel));

    }).catchError((error){
      favorites![productId] =!favorites![productId]!;
      print(error.toString());
      emit(ShopErrorFavoritesDataState());
    });
  }

  CategoriesModel? categoriesModel ;
  void getCategoriesData(){


    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // printFullText(homeModel?.data!.banners[0].image);
      print(token);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });

  }

  FavoritesModel? favoritesModel ;
  void getFavorites(){

    emit(ShopLoadingFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());

      emit(ShopErrorGetFavoritesState());
    });

  }

  ShopLoginModel? userModel ;

  void getUserData(

      ){

    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,

      token: token,
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name);

      emit(ShopSuccessGetUserDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });

  }

  void updateUserData(
      {
        required String name,
        required String phone,
        required String email,
      }
      ){

    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      data: {
        'email':email,
        'phone':phone,
        'name':name,
      },
      url: UPDATE_PROFILE,
      token: token,
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      // printFullText(userModel!.data!.name);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error){
      // print(error.toString());
      emit(ShopErrorUpdateUserState());
    });

  }
}
