import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/layout/social.dart';
import 'package:learning/modules/login/register.dart';
import 'package:learning/modules/login/reset_password.dart';
import 'package:learning/shared/Cubit/logIn/loginCubit.dart';
import 'package:learning/shared/Cubit/logIn/shoploginstate.dart';
import 'package:learning/shared/compnents/component.dart';
import 'package:learning/shared/compnents/constants.dart';
import 'package:learning/shared/networking/lacal/cacheHelper.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<LoginCubit, SocialLoginStates>(
        listener: (context, state) {
        if(state is SocialLoginErroeState )
          {
            var snackBar = SnackBar(content: Text('Error , Confirm your information') , backgroundColor: Colors.red,);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        if (state is SocialLoginSuccessState)
        {
          CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
            print(state.uId);
            navigateAnd(context, SocialLayout());
          });
        }
      },
        builder: (context, state) {

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(150),
                              child: Container(
                                color: Colors.grey[300],
                                width: 180,
                                height: 180,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                radius: 80.0,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.person , size: 120,color: defaultHexColor,),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 40,),
                        defaultTextFormFeild(
                          HintText: 'Email Address',
                          pre: Icons.email_outlined,
                          KeyType: TextInputType.emailAddress,
                          controller: emailController,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Email Address must not be Empty !';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormFeild(
                          HintText: 'Password',
                          pre: Icons.password_outlined,
                          KeyType: TextInputType.visiblePassword,
                          suff: LoginCubit.get(context).suffix,
                          suffPress: ()
                          {
                            LoginCubit.get(context).chanegIcon();
                          },
                          submit: (value)
                          {
                          if (formKey.currentState.validate()) {
                              // LoginCubit.get(context).userLogin(
                              // email: emailController.text,
                              // password: passwordController.text);
                            }},
                              isObscure: LoginCubit.get(context).isAppear,
                              controller: passwordController,
                              validate: (String value)
                          {
                            if(value.isEmpty)
                              {
                                return 'Password is too short';
                              }
                          },
                        ),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, ResetPasswordScreen());
                                },
                                child: Text('Forget Password?' , style: TextStyle(decoration: TextDecoration.underline),)),
                          ],
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: double.infinity,
                          child: ConditionalBuilder(
                            condition: state is! SocialLoginLoadingState,
                            builder: (context) => defaultButton(
                              text: 'login',
                              onPress: () {
                                if (formKey.currentState.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);


                                }
                              },
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                   navigateTo(context, RegisterScreen());
                                },
                                child: Text('Sign up')),
                          ],
                        ),
                        Text('OR'),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          children: [
                            CircleAvatar(
                              child:
                                  Image(image: AssetImage('assets/facebook.png')),
                              radius: 40,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            CircleAvatar(
                              child:
                                  Image(image: AssetImage('assets/google.png')),
                              radius: 40,
                              backgroundColor: Colors.white,
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

    );
  }
}
