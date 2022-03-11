import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/shared/components/components.dart';

import '../../modules/social_app/new_post/new_post.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
    return BlocConsumer<SocialCubit, SocialStates>
      (
      listener: (context, state)
      {
        if(state is SocialNewPostStats)
        {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state)
      {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          extendBody: true,
          appBar: AppBar(
            title:  Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon:const Icon(Icons.notifications_none_outlined)),
              IconButton(onPressed: (){}, icon:const Icon(Icons.search)),
            ],
          ),

          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            buttonBackgroundColor: const Color(0xff2a79b8).withOpacity(0.8),
            backgroundColor: Colors.transparent,
            color: const Color(0xffc4dffa).withOpacity(0.7),
            height: 50,
            animationCurve: Curves.easeInOut,
            animationDuration:const Duration(milliseconds: 600),
            letIndexChange: (index){
              cubit.changeBottomNav(index);
              return false;
            },
            index: cubit.currentIndex,
            items: [
              Icon(Icons.home_outlined,color: cubit.colorItem(0),),
              Icon(Icons.chat_bubble_outline,color: cubit.colorItem(1),),
              Icon(Icons.post_add_outlined,color: cubit.colorItem(2),),
              Icon(Icons.supervised_user_circle_outlined,color: cubit.colorItem(3),),
              Icon(Icons.settings_outlined,color: cubit.colorItem(4),),
            ],
          ),
        );
      },


    );

  }


}
