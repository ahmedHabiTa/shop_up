import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_up/models/cart_model.dart';
import 'package:shop_up/models/favourite_model.dart';
import 'package:shop_up/screens/shop_screens/home/bloc/cubit.dart';
import 'package:shop_up/screens/shop_screens/home/bloc/states.dart';
class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body:ConditionalBuilder(
            condition: HomeCubit.get(context).cartModel.data.cartItems.length != 0,
            builder: (context) =>
                buildCartItemCard(HomeCubit.get(context).cartModel),
            fallback: (context) =>Center(child: Text('No Item in Cart yet!'),),
          ),
        );
      },

    );
  }
  Widget buildCartItemCard(CartModel cartModel){
    return  ListView.separated(
      itemCount: cartModel.data.cartItems.length,
      scrollDirection: Axis.vertical,
      separatorBuilder: (context,index) =>SizedBox(width: 8,),
      itemBuilder: (context,index) => Card(elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: (){},
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 200,
                      width: double.infinity,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Image(
                            image: NetworkImage(
                                cartModel.data.cartItems[index].product.image),
                            width: double.infinity,
                            height: 200,
                          ),
                          if (cartModel.data.cartItems[index].product.discount != 0)
                            Container(
                              color: Colors.red,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                'Discount',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      cartModel.data.cartItems[index].product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14, height: 1.3, color: Colors.black54),
                    ),
                    Row(
                      children: [
                        Text(
                          '${cartModel.data.cartItems[index].product.price.round()}',
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (cartModel.data.cartItems[index].product.discount != 0)
                          Text(
                            '${cartModel.data.cartItems[index].product.oldPrice.round()}',
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),

                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(
                    HomeCubit.get(context).carts[
                    cartModel.data.cartItems[index].product.id]
                        ? Icons.shopping_cart
                        : Icons.add_shopping_cart,
                    size: 20,
                  ),
                  onPressed: () {
                    HomeCubit.get(context).changeCart(cartModel.data.cartItems[index].product.id);
                  }),
            ],
          ),
        ),
      ),
    )  ;
  }
}
