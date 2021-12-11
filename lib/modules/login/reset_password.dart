
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/shared/Cubit/logIn/loginCubit.dart';
import 'package:learning/shared/Cubit/logIn/shoploginstate.dart';
import 'package:learning/shared/compnents/component.dart';

class ResetPasswordScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<LoginCubit , SocialLoginStates>
      (
        builder: (context , state){
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reset Password',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 25)),
                        SizedBox(height: 20,),
                        Text('Write down there your email to get verified',style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 15),),
                        SizedBox(height: 20,),
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
                        SizedBox(height: 20,),
                          defaultButton(onPress: ()
                        {
                          if(formKey.currentState.validate())
                          {

                            FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value) {
                              snackBar(context , text: 'Request have been sent');
                              Navigator.pop(context);
                            });
                          }
                        }, text: 'send request') ,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context , state){}
    );
  }
}
