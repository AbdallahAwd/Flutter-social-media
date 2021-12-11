import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/layout/social.dart';
import 'package:learning/shared/Cubit/logIn/loginCubit.dart';
import 'package:learning/shared/Cubit/logIn/shoploginstate.dart';
import 'package:learning/shared/compnents/component.dart';
import 'package:learning/shared/networking/lacal/cacheHelper.dart';

class EmailVerification extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var OTBController = TextEditingController();
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
                        Text('Verify Email',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 25)),
                        SizedBox(height: 20,),
                        Text('Write down there your email and click send then write down there the OTB to get verified',style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 15),),
                        SizedBox(height: 20,),
                        defaultTextFormFeild(
                          HintText: 'Email Address',
                          pre: Icons.email_outlined,
                          KeyType: TextInputType.emailAddress,
                          controller: emailController,
                          suff: Icons.send_outlined,
                          suffixWidget: InkWell(
                            onTap: (){
                              LoginCubit.get(context).sendEmail(emailController.text);
                            },
                            child: Text('send' , style: TextStyle(
                              color: Colors.green,
                            ),),
                          ),
                          suffPress: ()
                          {
                            LoginCubit.get(context).sendEmail(emailController.text);
                          },
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Email Address must not be Empty !';
                            }
                          },
                        ),
                        SizedBox(height: 20,),
                        defaultTextFormFeild(
                          HintText: 'OTB code',
                          pre: Icons.confirmation_number_outlined,
                          KeyType: TextInputType.number,
                          controller: OTBController,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'OTB is too short!!';
                            }
                          },
                        ),
                        SizedBox(height: 20,),
                        defaultButton(onPress: ()
                        {
                          if(formKey.currentState.validate())
                          {
                            LoginCubit.get(context).verifyOTB(emailController.text , OTBController.text);

                          }
                        }, text: 'Verify') ,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context , state)
        {
          if(state is OTBSendSuccessState)
            {
              snackBar(context, text: 'Sent to Email entered');
            }
          if(state is OTBSendErrorState)
            {
              snackBar(context, text: 'Can\'t Send' , color: Colors.red);
            }
          if(state is OTBVerifySuccessState)
            {
              snackBar(context, text: 'Verified');
              CacheHelper.saveData(key: 'OTB', value: true).then((value) {
                navigateAnd(context, SocialLayout());
              });
            }
          if(state is OTBVerifyErrorState)
            {
              snackBar(context, text: 'Check the code again!' , color: Colors.red);
            }
        }
    );
  }
}
