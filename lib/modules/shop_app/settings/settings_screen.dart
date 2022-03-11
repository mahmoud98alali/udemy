import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/shop_app/shop_layout/cubit/cubit.dart';
import 'package:udemy/layout/shop_app/shop_layout/cubit/states.dart';
import 'package:udemy/shared/components/components.dart';
import 'package:udemy/shared/components/contains.dart';

import '../../../models/shop_app/login_model.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => defaultItem(cubit.userModel!.data!,state),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget defaultItem(UserData model,state) {
    nameController.text = model.name!;
    phoneController.text = model.phone!;
    emailController.text = model.email!;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [

            if (state is ShopLoadingUpdateUserState)
              const   LinearProgressIndicator(),
            const SizedBox(height: 10,),

            const Image(
              image: AssetImage("assets/images/setting.png"),
              height: 180,
              width: 180,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        defultContainer(type: 'Name : ${model.name}'),
                        const SizedBox(
                          height: 10,
                        ),
                        defultContainer(type: 'Phone : ${model.phone}'),
                        const SizedBox(
                          height: 10,
                        ),
                        defultContainer(type: 'Email : ${model.email}'),
                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            defaultButton(
                function: () {
                  showBottomSheet(
                    context: context,
                    builder: (context) => SizedBox(
                      height: 400,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [

                                defaultFormField(
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  labelText: "Name",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name must is not empty';
                                    }
                                    return null;
                                  },
                                  prefixIcon: const Icon(Icons.person),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultFormField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  labelText: "phone",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Phone must is not empty';
                                    }
                                    return null;
                                  },
                                  prefixIcon: const Icon(Icons.phone),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  labelText: "Email",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email must is not empty';
                                    }
                                    return null;
                                  },
                                  prefixIcon: const Icon(Icons.person),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                defaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        ShopCubit.get(context).updateUserData(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            email: emailController.text);
                                        Navigator.pop(context);
                                      }
                                    },
                                    text: "UPDATE")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                text: "EDIT"),
            const SizedBox(
              height: 10,
            ),
            defaultButton(
                function: () {
                  singOut(context);
                },
                background: Colors.red,
                text: "LOGOUT"),
            defaultTextButton(
              isUpperCase: false ,
                onPressed: () {
                  ShopCubit.get(context).getUserData();
                },
                title: "Please refresh information  ^_^")
          ],
        ),
      ),
    );
  }

  Widget defultContainer({required String type}) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      height: 35,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(type),
      ));
}
