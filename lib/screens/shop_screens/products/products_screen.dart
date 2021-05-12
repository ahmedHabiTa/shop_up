import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_up/models/home_model.dart';
import 'package:shop_up/screens/shop_screens/categories/categories_screen.dart';
import 'package:shop_up/screens/shop_screens/home/bloc/cubit.dart';
import 'package:shop_up/screens/shop_screens/home/bloc/states.dart';

// ignore: must_be_immutable
class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeSuccessChangeFavouritesState) {
          if (state.changeFavouriteModel.status) {
            Fluttertoast.showToast(
                msg: state.changeFavouriteModel.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
        if (state is HomeSuccessChangeCartsState) {
          if (state.changeCartModel.status) {
            Fluttertoast.showToast(
                msg: state.changeCartModel.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: HomeCubit.get(context).homeModel != null,
            builder: (context) =>  SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Categories',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Categories(),
                    SizedBox(
                      height: 10,
                    ),
                    buildProductItemCard(
                        HomeCubit.get(context).homeModel, context),
                  ],
                ),
              ),

            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildProductItemCard(HomeModel homeModel, context) {
    return GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 5.0,
        childAspectRatio: 1 / 1.6,
        children: List.generate(
            homeModel.data.products.length,
            (index) => Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              //border: Border.all(color: Colors.black, width: 0.3),
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                height: 200,
                                width: 180,
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomStart,
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                          homeModel.data.products[index].image),
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                    if (homeModel
                                            .data.products[index].discount !=
                                        0)
                                      Container(
                                        color: Colors.red,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(
                                          'Discount',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Text(
                                homeModel.data.products[index].name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    height: 1.3,
                                    color: Colors.black54),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${homeModel.data.products[index].price.round()}',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.blue),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  if (homeModel.data.products[index].discount !=
                                      0)
                                    Text(
                                      '${homeModel.data.products[index].oldPrice.round()}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            IconButton(
                                icon: Icon(
                                  HomeCubit.get(context).favourites[
                                          homeModel.data.products[index].id]
                                      ? Icons.favorite
                                      : Icons.favorite_outline_rounded,
                                  size: 20,
                                ),
                                onPressed: () {
                                  HomeCubit.get(context).changeFavourites(
                                      homeModel.data.products[index].id);
                                }),
                            IconButton(
                                icon: Icon(
                                  HomeCubit.get(context).carts[
                                  homeModel.data.products[index].id]
                                      ? Icons.shopping_cart
                                      : Icons.add_shopping_cart,
                                  size: 20,
                                ),
                                onPressed: () {
                                  HomeCubit.get(context).changeCart(homeModel.data.products[index].id);
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
