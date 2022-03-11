import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/shop_app/shop_layout/cubit/cubit.dart';
import 'package:udemy/layout/shop_app/shop_layout/cubit/states.dart';
import 'package:udemy/models/shop_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context, state) {
          return  ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
            builder: (context) =>ListView.separated(
              physics:const BouncingScrollPhysics(),
              scrollDirection:Axis.vertical ,
              itemBuilder: (context, index) =>buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data![index]),
              separatorBuilder: (context,index)=> const Divider(),
              itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length,
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },

    );
  }
  Widget buildCatItem(DataModel model)=> Padding(
    padding: const EdgeInsets.all(8.0),
    child:
    Row(
      children:
      [
         SizedBox(
          height: 100,width: 100,
          child: Image(image: NetworkImage('${model.image}',)),
        ),
        const  SizedBox(
          width: 20,
        ),
         Text('${model.name}',style: const TextStyle(fontSize: 20.0),),
        const Spacer(),
        IconButton(
          onPressed: (){},
          icon:const Icon(
              Icons.arrow_forward_ios
          ),
        ),
      ],
    ),
  );
}

