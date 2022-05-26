import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/models/social_app/social_user_model.dart';
import 'package:udemy/modules/social_app/chats_details/chat_details_screens.dart';
import 'package:udemy/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (_, __) {},
      builder: (_, __) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (BuildContext context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildChatItem(SocialCubit.get(context).users[index],_),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (BuildContext context) => const Center(child: Text('Loading ...',style: TextStyle(color: Colors.grey),)),

        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model,_) => InkWell(
        onTap: () {
          navigateTo(_, ChatsDetailsScreens(userModel: model));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children:  [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
            const  SizedBox(
                width: 20.0,
              ),
              Text(
                '${model.name}',
                style:const TextStyle(
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      );
}
