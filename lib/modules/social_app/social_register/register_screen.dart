import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/social_layout.dart';
import '../../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndFinish(
              context,
              const SocialLayout(),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                const SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Image(
                      image: AssetImage('assets/images/login.jpg'),
                      fit: BoxFit.cover,
                    )),
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios),
                              color: Colors.black,
                            ),
                            Text(
                              "REGISTER",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(
                                      fontSize: 50.0,
                                      letterSpacing: 4,
                                      color: Colors.pink),
                            ),
                            const Text(
                              "Register now to Communicate with friends",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black45),
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
                                // if (formKey.currentState!.validate()) {
                                //   SocialRegisterCubit.get(context).userRegister(
                                //       email: emailController.text,
                                //       password: passwordController.text,
                                //       phone: phoneController.text,
                                //       name: nameController.text);
                                // }
                              },
                              isPassword:
                                  SocialRegisterCubit.get(context).isPassword,
                              prefixIcon: const Icon(Icons.lock_outline),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Password is too short';
                                }
                              },
                              suffixPressed: () {
                                SocialRegisterCubit.get(context)
                                    .ChangePasswordVisibility();
                              },
                              keyboardType: TextInputType.visiblePassword,
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.grey),
                              controller: passwordController,
                              colorSuffixIcon: Colors.pink,
                              suffixIcon:
                                  SocialRegisterCubit.get(context).suffix,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ConditionalBuilder(
                              condition: state is! SocialRegisterLoadingState,
                              builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialRegisterCubit.get(context)
                                        .userRegister(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            phone: phoneController.text,
                                            name: nameController.text);
                                  }
                                },
                                background: Colors.pink,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
