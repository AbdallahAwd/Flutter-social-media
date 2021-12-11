import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/shared/Cubit/logIn/loginCubit.dart';
import 'package:learning/shared/Cubit/social_App/Cubit.dart';
import 'package:learning/shared/compnents/constants.dart';
import 'package:learning/shared/networking/lacal/cacheHelper.dart';
import 'package:learning/shared/networking/remote/DioHelper.dart';

import 'layout/social.dart';
import 'modules/login/login.dart';
import 'shared/block_observer.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   DioHelper.init();
   await CacheHelper.init();
   // without click or see it's done in background
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
   bool isDark = CacheHelper.getData(key: 'isDark');

   OTB = CacheHelper.getData(key: 'OTB');

   uId = CacheHelper.getData(key: 'uId');
    var token  = await FirebaseMessaging.instance.getToken();
    print(token);
    FirebaseMessaging.onMessage.listen((event) {
      print(event.data.toString());
      // do something if you open app
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print(event.data.toString());
      // do something if you click on notification
    });
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(isDark ,OTB ,uId));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool isDark;
  final bool OTB;
  final String uId;


  MyApp(this.isDark , this.OTB , this.uId);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
        create: (BuildContext context) => LoginCubit()),
        BlocProvider(
        create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()..getAllUsers()),
      ],
      child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Social App',

              theme: lightTheme,
              home: startWidget(uId ,OTB ) ,
            ),
    );
  }
}
Widget startWidget(uId ,OTB )
{
  if (uId != null ) return SocialLayout();
  if (uId != null && OTB != null ) return SocialLayout();
  else return LogInScreen();
}

