import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/models/social_app/message_model.dart';
import 'package:udemy/models/social_app/social_user_model.dart';
import 'package:udemy/shared/styles/colors.dart';

class ChatsDetailsScreens extends StatelessWidget {
  SocialUserModel userModel;

  ChatsDetailsScreens({required this.userModel});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(
          receiverId: userModel.uId!,
        );
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (_, __) {},
          builder: (_, __) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text('${userModel.name}'),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.isNotEmpty,
                fallback: (BuildContext context) => const Center(
                  child: Text('Waiting ...'),
                ),
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics:const BouncingScrollPhysics(),
                            itemBuilder: (context,index)
                            {
                              var message = SocialCubit.get(context).messages[index];
                              if(SocialCubit.get(context).userModel!.uId == message.senderId)
                                {
                                return  buildMyMessage(message);
                                }
                             return buildMessage(message);
                            },
                            separatorBuilder: (_,__) => const SizedBox(height: 15.0,),
                            itemCount: SocialCubit.get(context).messages.length,
                          ),
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius:
                                BorderRadiusDirectional.circular(15.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: const InputDecoration(
                                      hintText: 'type your message here ...',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                color: defaultColor,
                                height: 50.0,
                                child: MaterialButton(
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                      receiverId: userModel.uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text,
                                    );
                                  },
                                  minWidth: 1.0,
                                  child: const Icon(
                                    Icons.send,
                                    size: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                )),
            child:  Text('${model.text}'),),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
                color: defaultColor.withOpacity(
                  .2,
                ),
                borderRadius: const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                )),
            child: Text('${model.text}'),),
      );
}
