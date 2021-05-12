import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_up/models/categories_model.dart';
import 'package:shop_up/screens/shop_screens/home/bloc/cubit.dart';
import 'package:shop_up/screens/shop_screens/home/bloc/states.dart';
class Categories extends StatelessWidget {
  static const routeName = '/categories' ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: HomeCubit.get(context).categoriesModel != null ,
          builder: (context) => buildCategoriesBar(HomeCubit.get(context).categoriesModel),
          fallback:  (context) => Center(child: CircularProgressIndicator()),
        );
      },

    );
  }
  Widget buildCategoriesBar(CategoriesModel categoriesModel){

    return Container(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
          separatorBuilder: (context,index) =>SizedBox(width: 8,),
          itemBuilder: (context,index) =>categoryCard(categoriesModel.data.listData[index].name),
          itemCount: categoriesModel.data.listData.length),
    );
  }
  Widget categoryCard(String text){
    return Container(
      height: 50,
      width: 100,
      child: Card(
        borderOnForeground: true,
        color:Colors.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20))
        ),
        child: Center(
          child: InkWell(
          onTap: (){},
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),topLeft: Radius.circular(15)) ,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(
                transform: Matrix4.rotationZ(0.2),
                    child: Text(text,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15),
          ),

              ),
            ),
      ),
        )),
    );
  }
}
