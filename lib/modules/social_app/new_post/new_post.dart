import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';

import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Create Post', actions: [
            defaultTextButton(
              onPressed: () {
                var now = DateTime.now();
                if (cubit.postImage == null) {
                  cubit.createPost(
                    text: textController.text,
                    dateTime: now.toString(),
                  );
                } else {
                  cubit.uploadPostImage(
                    text: textController.text,
                    dateTime: now.toString(),
                  );
                }
              },
              title: 'Post',
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
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/confused-unshaven-man-with-dark-bristle-spreads-palms-feels-uncertain-looks-displeasure_273609-23760.jpg?w=826'),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Text(
                        'Mahmoud Ali',
                        style: TextStyle(
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
               const SizedBox(height: 10.0,),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'What is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
               const SizedBox(height: 5.0,),
                if (cubit.postImage != null)

                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0,),
                          image: DecorationImage(
                              image: FileImage(cubit.postImage!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.removePostImage();
                        },
                        icon: const CircleAvatar(
                            radius: 14.0,
                            child: Icon(
                              Icons.close,
                              size: 18.0,
                            )),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.image,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('add photo'),
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('#  tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
