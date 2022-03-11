import 'package:flutter/material.dart';
import 'package:udemy/modules/social_app/new_post/new_post.dart';
import 'package:udemy/shared/components/components.dart';

class NewPostNavScreen extends StatelessWidget {
  const NewPostNavScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              navigateTo(context, NewPostScreen());
            },
            child: const CircleAvatar(radius: 70,
              backgroundImage:
                NetworkImage('https://c.tenor.com/UITUVRmPExYAAAAC/new-post-black-yallow.gif'),
            ),
          ),
         const SizedBox(height: 20,),

          Text('^ـــــ^',
          style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 18.0),),
          Text('....',
            style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 18.0),),
          Text('..',
            style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 18.0),),

        ],
      ),
    );
  }
}
