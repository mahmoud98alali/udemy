import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/shop_app/shop_layout/cubit/cubit.dart';
import 'package:udemy/layout/shop_app/shop_layout/cubit/states.dart';
import 'package:udemy/models/shop_app/categories_model.dart';
import 'package:udemy/models/shop_app/home_model.dart';
import 'package:udemy/shared/components/components.dart';
import 'package:udemy/shared/styles/colors.dart';

import '../products_items/products_items.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

        if(state is ShopSuccessChangeFavoriteState){

          if(!state.model!.status!){

            showToast(text: state.model!.message!, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {

        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          builder: (context) =>
              productsBuilder(ShopCubit.get(context).homeModel!, ShopCubit.get(context).categoriesModel! ,context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel,context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200,
                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children:
               [
                 const Text('Categories',style: TextStyle(fontSize: 25.0),),
                 SizedBox(
                   height: 100,
                   child: ListView.separated(
                     physics: const BouncingScrollPhysics(),
                     shrinkWrap: true,
                     scrollDirection: Axis.horizontal,
                     itemBuilder:(context, index) => buildCategoryItem(categoriesModel.data!.data![index]) ,
                     separatorBuilder: (context,index)=>const SizedBox(width: 10.0,),
                     itemCount: categoriesModel.data!.data!.length,
                   ),
                 ),
                 const SizedBox(
                   height: 20.0,
                 ),
                 const Text('New Products',style: TextStyle(fontSize: 25.0),),
               ],),
           ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.65,
                children: List.generate(
                  model.data!.products.length,
                  (index) => buildGridProduct(model.data!.products[index],context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductsModel model,context) => InkWell(
    onTap: (){
      navigateTo(context, ProductsItems());
    },
    child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image!),
                    width: double.infinity,
                    height: 200,
                  ),
                  if (model.discount != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      color: Colors.red,
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0,left: 8,right: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 45,
                      child: Text(
                        '${model.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 15.0, height: 1.2),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Text(
                            '${model.price.round()}',
                            style: const TextStyle(
                              color: defaultColor,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice}',
                              style: const TextStyle(
                                fontSize: 11.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context).changeFavoritesData(model.id!);

                            },
                            icon: CircleAvatar(
                              radius: 17,
                              backgroundColor: ShopCubit.get(context).favorites![model.id]! ? defaultColor :Colors.grey,
                                child: Icon(Icons.favorite_sharp,size: 20,
                                  color: ShopCubit.get(context).favorites![model.id]! ? Colors.red :Colors.white,)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
  );

Widget buildCategoryItem(DataModel model)=> Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children:
  [
     Image(
      image: NetworkImage("${model.image}"),
      height: 100,width: 100,
      fit:BoxFit.cover,
    ),

    Container(
      width: 100,
      color: Colors.black.withOpacity(.8),
      child:  Text("${model.name}",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
        ),),
    ),
  ],
);
}
