import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/modules/shop_app/register_screen/cubit/cubit.dart';
import 'package:udemy/modules/shop_app/register_screen/cubit/states.dart';

import '../../../layout/shop_app/shop_layout/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/contains.dart';
import '../../../shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState ) {
            if (state.loginModel!.status!) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel!.data!.token,
              ).then((value) {
                token = state.loginModel!.data!.token!;
                navigateAndFinish(context, const ShopLayout());
              });
            }else {
              showToast(
                  text: '${state.loginModel!.message}',
                  state: ToastStates.ERROR
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "REGISTER",
                          style:
                              Theme.of(context).textTheme.headline5?.copyWith(
                                    fontSize: 50.0,
                                  ),
                        ),
                        const Text(
                          "Register now to browse our hot offers ",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          prefixIcon: const Icon(Icons.person),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Name is must not empty';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          labelText: 'Name',
                          labelStyle: const TextStyle(color: Colors.grey),
                          controller: nameController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          prefixIcon: const Icon(Icons.email_outlined),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Email is must not empty';
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'Email Address',
                          labelStyle: const TextStyle(color: Colors.grey),
                          controller: emailController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          prefixIcon: const Icon(Icons.phone),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                          },
                          keyboardType: TextInputType.phone,
                          labelText: 'Phone',
                          labelStyle: const TextStyle(color: Colors.grey),
                          controller: phoneController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  name: nameController.text);
                            }
                          },
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          prefixIcon: const Icon(Icons.lock_outline),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .ChangePasswordVisibility();
                          },
                          keyboardType: TextInputType.visiblePassword,
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.grey),
                          controller: passwordController,
                          suffixIcon: ShopRegisterCubit.get(context).suffix,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    name: nameController.text);
                                print(emailController.text);
                              }
                            },
                            text: "Register",
                            isUpperCase: true,
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
