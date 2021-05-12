import 'package:shop_up/models/change_cart.dart';
import 'package:shop_up/models/change_favourites.dart';

class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeChangeBottomState extends HomeStates {}

class HomeLoadingProductState extends HomeStates {}

class HomeSuccessProductState extends HomeStates {}

class HomeErrorProductState extends HomeStates {}

class HomeSuccessCategoryState extends HomeStates {}

class HomeErrorCategoryState extends HomeStates {}

class HomeInitialChangeFavouritesState extends HomeStates {}

class HomeSuccessChangeFavouritesState extends HomeStates {
  final ChangeFavouriteModel changeFavouriteModel;

  HomeSuccessChangeFavouritesState(this.changeFavouriteModel);
}

class HomeErrorChangeFavouritesState extends HomeStates {}

class HomeInitialGetFavouritesState extends HomeStates {}

class HomeSuccessGetFavouritesState extends HomeStates {}

class HomeErrorGetFavouritesState extends HomeStates {}

class HomeInitialChangeCartsState extends HomeStates {}

class HomeSuccessChangeCartsState extends HomeStates {
  final ChangeCartModel changeCartModel;

  HomeSuccessChangeCartsState(this.changeCartModel);
}

class HomeErrorChangeCartsState extends HomeStates {}

class HomeInitialGetCartsState extends HomeStates {}

class HomeSuccessGetCartsState extends HomeStates {}

class HomeErrorGetCartsState extends HomeStates {}
