import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/models/shop_app/favorites_model.dart';
import '../../../layout/shop_app/shop_layout/cubit/cubit.dart';
import '../../../layout/shop_app/shop_layout/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context, state) {
        return  ConditionalBuilder(
          condition: ShopCubit.get(context).favoritesModel != null  && ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          builder: (context) =>ListView.separated(
            physics:const BouncingScrollPhysics(),
            scrollDirection:Axis.vertical ,
            itemBuilder: (context, index) =>buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data[index].product!,context),
            separatorBuilder: (context,index)=> const Divider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length ,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },

    );
  }


}
