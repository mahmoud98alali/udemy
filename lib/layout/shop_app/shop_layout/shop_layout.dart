import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/shop_app/shop_layout/cubit/cubit.dart';
import 'package:udemy/layout/shop_app/shop_layout/cubit/states.dart';
import 'package:udemy/modules/shop_app/search/search_screen.dart';
import 'package:udemy/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [

              IconButton(onPressed: (){
                navigateTo(context,const SearchScreen());
              },
                  icon: const Icon(Icons.search,color: Colors.black,)),
            ],
            title: Text(
              'Al-ALi Market',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
              cubit.getHomeData();
              cubit.getCategoriesData();
              cubit.getUserData();
              cubit.getFavorites();

            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apps,
                  ),
                  label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_outline,
                  ),
                  label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Settings'),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
        );
      },
    );
  }
}
