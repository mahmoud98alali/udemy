import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>
      (
      listener: (context, state) {},
      builder: (context, state)
      {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:  Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon:const Icon(Icons.notifications_none_outlined)),
              IconButton(onPressed: (){}, icon:const Icon(Icons.search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
            items:const [
               BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home'),
               BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline),label: 'Chats'),
               BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle_outlined),label: 'Users'),
               BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label: 'Setting'),
            ],
          ),
        );
      },
    );
  }
}
