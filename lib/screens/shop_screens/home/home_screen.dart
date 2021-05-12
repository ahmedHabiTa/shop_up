import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_up/network/local/shared_pref_helper.dart';
import 'package:shop_up/screens/login/login_screen.dart';
import 'package:shop_up/screens/shop_screens/cart/cart_screen.dart';
import 'package:shop_up/screens/shop_screens/home/bloc/cubit.dart';
import 'package:shop_up/screens/shop_screens/home/bloc/states.dart';
import 'package:shop_up/screens/shop_screens/search/search_screen.dart';
class HomePage extends StatelessWidget {
  static const routeName = '/homePage' ;
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context );
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
            appBar: AppBar(
              title: Text('Store'),
              centerTitle: true,
              actions: [
                TextButton(onPressed: (){
                  SharedPrefsHelper.deleteData(key: 'token').then((value){
                    if(value == true){
                      Navigator.of(context).pushReplacementNamed(Login.routeName);
                    }
                  });
                }, child: Text('logout')),
                IconButton(icon: Icon(Icons.search), onPressed: (){
                  Navigator.of(context).pushNamed(SearchScreen.routeName);
                }),
                SizedBox(width: 5,),
                IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                }),
              ],
            ),
            body :cubit.prodFavScreen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon:Icon(Icons.home),
                    label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon:Icon(Icons.favorite_outlined),
                    label: 'Favourites'
                ),
              ],
            )
        );
      },
    );
  }
}
