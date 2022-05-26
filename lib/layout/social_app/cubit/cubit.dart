import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/models/social_app/message_model.dart';
import 'package:udemy/models/social_app/post_model.dart';
import 'package:udemy/models/social_app/social_user_model.dart';
import 'package:udemy/modules/social_app/chats/chats_screen.dart';
import 'package:udemy/modules/social_app/feeds/feeds_screen.dart';
import 'package:udemy/modules/social_app/settings/settings_screen.dart';
import 'package:udemy/modules/social_app/users/users_screen.dart';
import 'package:udemy/shared/components/contains.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../modules/social_app/new_post/new_post_nav.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingStates());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);

      emit(SocialGetUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorStates(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const NewPostNavScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if(index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(SocialNewPostStats());
    } else {
      emit(SocialChangeBottomNavStats());
      currentIndex = index;
    }
  }

  File? profileImage;
  var image;
  var picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      image = basename(pickedFile.path);
      print(image);
      emit(SocialProfileImagePickedSuccessStats());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorStats());
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessStats());
    } else {
      print('No image selected');
      emit(SocialCoverImagePickedErrorStats());
    }
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    emit(SocialUserUpdateLoadingStats());
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorStats());
    });
  }


  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateProfileLoadingStats());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        // emit(SocialUploadProfileImageSuccessStats());
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageErrorStats());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorStats());
      print('Error : ${error.toString()}');
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateCoverLoadingStats());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        // emit(SocialUploadCoverImageSuccessStats());
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadCoverImageErrorStats());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorStats());
      print('Error : ${error.toString()}');
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingStats());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if(coverImage != null && profileImage != null ){
  //
  //   } else  {
  //     updateUser(phone: phone, name: name, bio: bio);
  //   }
  // }


//  uploadProfileImage() async{
//     var refStorage = FirebaseStorage.instance.ref('images/$image');
//
//     await refStorage.putFile(profileImage!);
//     var url = refStorage.getDownloadURL();
//
//     print('url : $url');
// }

//String? name ;
//   String? uId ;
//   String? image ;
//   String? dateTime ;
//   String? text ;
//   String? postImage ;

  File? postImage;

  Future getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessStats());
    } else {
      print('No image selected');
      emit(SocialPostImagePickedErrorStats());
    }
  }

  void removePostImage(){
    postImage = null;
    emit(SocialRemoveImagePickedStats());
  }
  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(SocialCreatePostLoadingStats());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);

        createPost(
          text: text,
          postImage: value,
          dateTime: dateTime,
        );
      }).catchError((error) {
        print(error.toString());
        emit(SocialCreatePostErrorStats());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorStats());
      print('Error : ${error.toString()}');
    });
  }

  void createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingStats());
    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {

      emit(SocialCreatePostSuccessStats());
    })
        .catchError((error) {
      emit(SocialCreatePostErrorStats());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  // List<int> comments = [];

  void getPosts(){
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
      for (var element in value.docs) {
        // element.reference.collection('comments').get().then((value) {
        //   comments.add(value.docs.length);
        //   postId.add(element.id);
        //   posts.add(PostModel.fromJson(element.data()));
        // }).catchError((onError){});
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error){});

      }
      emit(SocialGetPostsSuccessStates());
    })
        .catchError((error){
      emit(SocialGetPostsErrorStates(error.toString()));
    });
  }

  void likePost(String? postId){
    FirebaseFirestore.instance.collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like':true,
    })
        .then((value) {
      emit(SocialLikePostSuccessStates());
    })
        .catchError((error){
      emit(SocialLikePostErrorStates(error.toString()));
    });
  }
  Color colorItem(int i){

    return currentIndex==i?Colors.white:Colors.black;
  }

//
// void getComments({
//   String? commentsId,
//   String? comment,
// }){
//   FirebaseFirestore.instance.collection('posts')
//       .doc(commentsId)
//       .collection('comments')
//       .doc(userModel!.uId)
//       .set({
//     'comments':comment,
//   })
//       .then((value) {
//     emit(SocialCommentsPostSuccessStates());
//   })
//       .catchError((error){
//     emit(SocialCommentsPostErrorStates(error.toString()));
//   });
// }


List<SocialUserModel> users = [];


  void getUsers()
  {
    if(users.isEmpty) {
      FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      for (var element in value.docs) {
          if(element.data()['uId'] != userModel!.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }

      }
      emit(SocialGetAllUsersSuccessStates());
    })
        .catchError((error){
      emit(SocialGetAllUsersErrorStates(error.toString()));
    });
    }
  }

  void sendMessage({
  required String receiverId,
  required String dateTime,
  required String text,
})
  {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessStates());
    }
    ).catchError((error)
    {
      emit(SocialSendMessageErrorStates(error.toString()));
    }
    );

    // set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessStates());
    }
    ).catchError((error)
    {
      emit(SocialSendMessageErrorStates(error.toString()));
    }
    );
  }



  List<MessageModel> messages = [];

  void getMessages({
  required String receiverId})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
    .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(SocialGetMessageSuccessStates());
    }
    );
  }
}
