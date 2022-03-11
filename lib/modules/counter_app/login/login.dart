
import 'package:flutter/material.dart';
import 'package:udemy/shared/components/components.dart';

class LoginIBM extends StatefulWidget {
  const LoginIBM({Key? key}) : super(key: key);

  @override
  State<LoginIBM> createState() => _LoginIBMState();
}

class _LoginIBMState extends State<LoginIBM> {

  var emailController = TextEditingController() ;
  var passController = TextEditingController() ;
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;
  int? a =0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start  ,
                children: [
                  Container(
                    child:const Text("Login" ,
                      style: TextStyle(fontSize: 55.0,
                          fontWeight: FontWeight.bold),
                    ) ,
                  ),
                  const SizedBox(height: 40,),
                  defaultFormField(
                    labelText: "Email Address",
                    controller: emailController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "email address must not be empty";
                      }
                      return null ;
                    },
                      prefixIcon: Icon(Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    onChange: (String value){
                      print(value);
                    },
                    onSubmit: (String value){
                      print(value);
                    },
                  ),

                  const SizedBox(height: 20,),
                  defaultFormField(
                    labelText: "Password",
                    controller: passController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "password must not be empty";
                      }
                      return null ;
                    },
                    prefixIcon: Icon(Icons.email_outlined),

                    suffixIcon:isPassword == false ? Icons.visibility: Icons.visibility_off,

                    keyboardType: TextInputType.visiblePassword,
                    suffixPressed: ()
                    {
                      setState(() {
                          isPassword=!isPassword;
                      });

                          print(isPassword);
                    },
                    isPassword:isPassword,
                    onChange: (String value){
                      print(value);
                    },
                    onSubmit: (String value){
                      print(value);
                    },


                  ),

                  const SizedBox(height: 20,),
                  defaultButton(
                    text: "Login",function: (){
                    if(formKey.currentState!.validate()){
                      print(emailController.text);
                      print(passController.text);
                    }
                  },),
                  const SizedBox(height: 20,),

                  defaultButton(
                    text: "Register",function: (){

                      if(formKey.currentState!.validate()){
                        print(emailController.text);
                        print(passController.text);
                      }

                  },),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Text("Don't have an account?"),
                      TextButton(onPressed: (){
                      },
                          child: const Text("Register Now")),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
