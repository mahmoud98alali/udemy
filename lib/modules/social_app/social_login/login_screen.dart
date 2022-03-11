import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/social_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../social_register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if (state is SocialLoginSuccessState) {

            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              navigateAndFinish(
                context,
                const SocialLayout(),
              );
            });
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
                            Text(
                              "Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(
                                  fontSize: 60.0,
                                  letterSpacing: 12,
                                  color: Colors.pink),
                            ),
                            const Text(
                              "Login now to Communicate with friends",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black45),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              cursorColor: Colors.pink,
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.pink,
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Email is must not empty';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              labelText: 'Email Address',
                              labelStyle:
                              const TextStyle(color: Colors.black45),
                              controller: emailController,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              isPassword:
                              SocialLoginCubit.get(context).isPassword,
                              prefixIcon: const Icon(Icons.lock_outline,
                                  color: Colors.pink),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Password is too short';
                                }
                                return null;
                              },
                              suffixPressed: () {
                                SocialLoginCubit.get(context)
                                    .ChangePasswordVisibility();
                              },
                              cursorColor: Colors.pink,
                              keyboardType: TextInputType.visiblePassword,
                              labelText: 'Password',
                              labelStyle:
                              const TextStyle(color: Colors.black45),
                              controller: passwordController,
                              colorSuffixIcon: Colors.pink,
                              suffixIcon: SocialLoginCubit.get(context).suffix,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ConditionalBuilder(
                              condition: state is! SocialLoginLoadingState,
                              builder: (context) => defaultButton(
                                background: Colors.pink,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: "login",
                                isUpperCase: true,
                              ),
                              fallback: (context) => const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an account'),
                                defaultTextButton(
                                  onPressed: () {
                                    navigateTo(context, SocialRegisterScreen());
                                  },
                                  title: "Register",
                                  style: const TextStyle(
                                    color: Colors.pink,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
