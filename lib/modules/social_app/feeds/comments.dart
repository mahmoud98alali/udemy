import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/models/social_app/post_model.dart';

import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class CommentsPost extends StatelessWidget {
  var textController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar:
          defaultAppBar(context: context, title: 'New Comments', actions: [
            defaultTextButton(
              onPressed: () {

                // cubit.getComments(comment: textController.text);

              },
              title: 'Add',
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingStats)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingStats)
                  const SizedBox(
                    height: 10.0,
                  ),

                const SizedBox(height: 10.0,),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Add your comments ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),

              ],
            ),
          ),
        );


      },
    );
  }



}
