import 'package:udemy/models/shop_app/login_model.dart';

import '../../../../models/shop_app/change_favorites.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}
class ShopChangeBottomNavState extends ShopStates {}
class ShopLoadingHomeDataState extends ShopStates {}
class ShopSuccessHomeDataState extends ShopStates {}
class ShopErrorHomeDataState extends ShopStates {}
class ShopSuccessCategoriesState extends ShopStates {}
class ShopErrorCategoriesState extends ShopStates {}


class ShopSuccessFavoritesDataState extends ShopStates {}
class ShopSuccessChangeFavoriteState extends ShopStates {
  final ChangeFavoritesModel? model;
  ShopSuccessChangeFavoriteState(this.model);
}
class ShopErrorFavoritesDataState extends ShopStates {}

class ShopLoadingFavoritesState extends ShopStates {}
class ShopSuccessGetFavoritesState extends ShopStates {}
class ShopErrorGetFavoritesState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {}
class ShopErrorGetUserDataState extends ShopStates {}
class ShopLoadingUserDataState extends ShopStates {}

class ShopChangeShowBottomSheetState extends ShopStates {}


class ShopSuccessUpdateUserState extends ShopStates {

  final ShopLoginModel loginModel ;
  ShopSuccessUpdateUserState(this.loginModel);
}
class ShopErrorUpdateUserState extends ShopStates {}
class ShopLoadingUpdateUserState extends ShopStates {}