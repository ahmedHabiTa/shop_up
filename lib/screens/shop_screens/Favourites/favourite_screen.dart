import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_up/models/favourite_model.dart';
import 'package:shop_up/screens/shop_screens/home/bloc/cubit.dart';
import 'package:shop_up/screens/shop_screens/home/bloc/states.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: ConditionalBuilder(
              condition: HomeCubit.get(context).favouriteModel.data.listData.length != 0,
              builder: (context) =>
                  buildFavouriteItemCard(HomeCubit.get(context).favouriteModel),
              fallback: (context) =>Center(child: Text('No Favourites yet!'),),
            ),
          );
        },

    );
  }
  Widget buildFavouriteItemCard(FavouriteModel favouriteModel){
    return ListView.separated(
      itemCount: favouriteModel.data.listData.length,
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
                                favouriteModel.data.listData[index].product.image),
                            width: double.infinity,
                            height: 200,
                          ),
                          if (favouriteModel.data.listData[index].product.discount != 0)
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
                      favouriteModel.data.listData[index].product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14, height: 1.3, color: Colors.black54),
                    ),
                    Row(
                      children: [
                        Text(
                          '${favouriteModel.data.listData[index].product.price.round()}',
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (favouriteModel.data.listData[index].product.discount != 0)
                          Text(
                            '${favouriteModel.data.listData[index].product.oldPrice.round()}',
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
                    HomeCubit.get(context).favourites[favouriteModel.data.listData[index].product.id] ? Icons.favorite :Icons.favorite_outline_rounded,
                    size: 20,
                  ),
                  onPressed: () {
                    HomeCubit.get(context).changeFavourites(favouriteModel.data.listData[index].product.id);
                  }),
            ],
          ),
        ),

      ),
    ) ;
  }
}
