import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/shop_app/shop_layout/shop_layout.dart';
import 'package:udemy/modules/shop_app/login_screen/cubit/cubit.dart';
import 'package:udemy/modules/shop_app/login_screen/cubit/states.dart';
import 'package:udemy/modules/shop_app/register_screen/register_screen.dart';
import 'package:udemy/shared/network/local/cache_helper.dart';
import 'package:udemy/shared/styles/colors.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/contains.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel!.status!) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel!.data!.token,
              ).then((value) {

                token = state.loginModel!.data!.token!;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              showToast(
                  text: '${state.loginModel!.message}',
                  state: ToastStates.ERROR);
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
                          "Login",
                          style:
                              Theme.of(context).textTheme.headline5?.copyWith(
                                    fontSize: 50.0,
                                  ),
                        ),
                        const Text(
                          "Login now to browse our hot offers ",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
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
                            return null;
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
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          prefixIcon: const Icon(Icons.lock_outline),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .ChangePasswordVisibility();
                          },
                          keyboardType: TextInputType.visiblePassword,
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.grey),
                          controller: passwordController,
                          suffixIcon: ShopLoginCubit.get(context).suffix,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: "login",
                            isUpperCase: true,
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account'),
                            defaultTextButton(
                              onPressed: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              title: "Register",
                              style: const TextStyle(
                                color: defaultColor,
                              ),
                            ),
                          ],
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
