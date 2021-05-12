import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_up/components/constants.dart';
import 'package:shop_up/models/cart_model.dart';
import 'package:shop_up/models/categories_model.dart';
import 'package:shop_up/models/change_cart.dart';
import 'package:shop_up/models/change_favourites.dart';
import 'package:shop_up/models/favourite_model.dart';
import 'package:shop_up/models/home_model.dart';
import 'package:shop_up/network/end_points.dart';
import 'package:shop_up/network/local/shared_pref_helper.dart';
import 'package:shop_up/network/remote/dio_helper.dart';
import 'package:shop_up/screens/shop_screens/Favourites/favourite_screen.dart';
import 'package:shop_up/screens/shop_screens/home/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:shop_up/screens/shop_screens/products/products_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> prodFavScreen = [
    ProductsScreen(),
    FavouritesScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(HomeChangeBottomState());
  }

  HomeModel homeModel;
  Map<int, bool> favourites = {};
  Map<int, bool> carts = {};
  String token =  SharedPrefsHelper.getData(key:'tok');
  void getHomeData() {
    emit(HomeLoadingProductState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favourites.addAll(
            {element.id: element.inFavorites}
        );
      });
      homeModel.data.products.forEach((element) {
        carts.addAll({
          element.id : element.inCart
        });
      });
      emit(HomeSuccessProductState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorProductState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(HomeSuccessCategoryState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorCategoryState());
    });
  }

  ChangeFavouriteModel changeFavouriteModel;

  void changeFavourites(int productID) {
    favourites[productID] = !favourites[productID] ;
    emit(HomeInitialChangeFavouritesState());
    DioHelper.postData(
        url: FAVOURITES, data: {'product_id': productID}, token: token)
        .then((value) {
    changeFavouriteModel = ChangeFavouriteModel.fromJson(value.data);
    if(!changeFavouriteModel.status){
      favourites[productID] = !favourites[productID] ;
    }else{
      getFavourites();
    }
    emit(HomeSuccessChangeFavouritesState(changeFavouriteModel));
    }).catchError((error) {
      favourites[productID] = !favourites[productID] ;
    emit(HomeErrorChangeFavouritesState());
    });
  }
  FavouriteModel favouriteModel;
  void getFavourites() {

    emit(HomeInitialGetFavouritesState());
    DioHelper.getData(
      url: FAVOURITES,
      token: token,
    ).then((value) {
      favouriteModel = FavouriteModel.fromJson(value.data) ;
      emit(HomeSuccessGetFavouritesState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorGetFavouritesState());
    });
  }

  ChangeCartModel changeCartModel;

  void changeCart(int productID) {
    carts[productID] = !carts[productID] ;
    emit(HomeInitialChangeCartsState());
    DioHelper.postData(
        url: CARTS, data: {'product_id': productID}, token: token)
        .then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);
      if(!changeCartModel.status){
        carts[productID] = !carts[productID] ;
      }else{
        getCarts();
      }

      emit(HomeSuccessChangeCartsState(changeCartModel));
    }).catchError((error) {
      carts[productID] = !carts[productID] ;
      emit(HomeErrorChangeCartsState());
    });
  }
  CartModel cartModel;
  void getCarts() {
    emit(HomeInitialGetCartsState());
    DioHelper.getData(
      url: CARTS,
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(HomeSuccessGetCartsState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorGetCartsState());
    });
  }
}
