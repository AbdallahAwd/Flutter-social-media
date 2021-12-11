import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/modules/login/email_verification.dart';
import 'package:learning/modules/login/login.dart';
import 'package:learning/shared/Cubit/logIn/loginCubit.dart';
import 'package:learning/shared/Cubit/logIn/shoploginstate.dart';
import 'package:learning/shared/compnents/component.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<LoginCubit , SocialLoginStates >(
       listener: (context , state){
         if (state is SocialCreateUserSuccessState)
           {
             navigateAnd(context, EmailVerification());
           }
       },
       builder: (context , state)
       {
         return Scaffold(
           body: Padding(
             padding: const EdgeInsets.all(20.0),
             child: Center(
               child: SingleChildScrollView(
                 physics: NeverScrollableScrollPhysics(),
                 child: Form(
                   key: formKey,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('REGISTER' , style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 35),),
                       SizedBox(
                         height: 25.0,
                       ),
                       Text('Easy Communicate with each other' , style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18),),
                       SizedBox(
                         height: 20.0,
                       ),
                       defaultTextFormFeild(
                         HintText: 'Full Name',
                         pre: Icons.person,
                         KeyType: TextInputType.text,
                         controller: nameController,
                         validate: (String value)
                         {
                           if(value.isEmpty)
                           {
                             return 'Name must not be Empty !';
                           }
                         },
                       ),
                       SizedBox(
                         height: 20.0,
                       ),
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
                         HintText: 'Phone',
                         pre: Icons.phone_android_outlined,
                         KeyType: TextInputType.number,
                         controller: phoneController,
                         validate: (String value)
                         {
                           if(value.isEmpty)
                           {
                             return 'Phone  must not be Empty !';
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
                             LoginCubit.get(context).userRegister(
                                 email: emailController.text,
                                 password: passwordController.text,
                                 phone: phoneController.text,
                                 name: nameController.text,
                             );
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
                      SizedBox(height: 20,),
                       Container(
                         height: 40,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(100.0),
                         ),
                         clipBehavior: Clip.antiAliasWithSaveLayer,
                         width: double.infinity,
                         child: ConditionalBuilder(
                           condition: state is! SocialRegisterLoadingState,
                           builder: (context) => defaultButton(
                             text: 'register',
                             onPress: () {
                               if (formKey.currentState.validate()) {
                                 LoginCubit.get(context).userRegister(
                                   email: emailController.text,
                                   password: passwordController.text,
                                   phone: phoneController.text,
                                   name: nameController.text,
                                 );

                               }
                             },
                           ),
                           fallback: (context) =>
                               Center(child: CircularProgressIndicator()),
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
    );
  }
}
