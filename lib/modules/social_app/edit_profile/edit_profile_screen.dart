import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', actions: [
            defaultTextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                title: 'Update'),
            const SizedBox(
              width: 15.0,
            ),
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingStats)
                    const LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingStats)
                    const SizedBox(
                      height: 10.0,
                    ),
                  SizedBox(
                    height: 180.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              coverImage == null
                                  ? Container(
                                      height: 140,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${userModel.cover}'),
                                            fit: BoxFit.cover),
                                      ),
                                    )
                                  : Container(
                                      height: 140,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                        image: DecorationImage(
                                            image: FileImage(coverImage),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                    radius: 16.0,
                                    child: Icon(
                                      Icons.camera,
                                      size: 20.0,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            profileImage == null
                                ? CircleAvatar(
                                    radius: 58.0,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: CircleAvatar(
                                      radius: 55.0,
                                      backgroundImage:
                                          NetworkImage('${userModel.image}'),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 58.0,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: CircleAvatar(
                                      radius: 55.0,
                                      backgroundImage: FileImage(profileImage),
                                    ),
                                  ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                  radius: 16.0,
                                  child: Icon(
                                    Icons.camera,
                                    size: 20.0,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultButton(
                                  function: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  text: 'upload profile'),
                              if (state is SocialUserUpdateProfileLoadingStats)
                                const SizedBox(
                                  height: 5.0,
                                ),
                              if (state is SocialUserUpdateProfileLoadingStats)
                                const LinearProgressIndicator(),
                            ],
                          )),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultButton(
                                  function: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  text: 'upload cover'),
                              if (state is SocialUserUpdateCoverLoadingStats)
                                const SizedBox(
                                  height: 5.0,
                                ),
                              if (state is SocialUserUpdateCoverLoadingStats)
                                const LinearProgressIndicator(),
                            ],
                          )),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    const SizedBox(
                      height: 20.0,
                    ),
                  defaultFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    labelText: "Name",
                    prefixIcon: const Icon(Icons.person_outline),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    labelText: "Bio",
                    prefixIcon: const Icon(Icons.info_outline),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    labelText: "Phone",
                    prefixIcon: const Icon(Icons.phone_android_outlined),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
