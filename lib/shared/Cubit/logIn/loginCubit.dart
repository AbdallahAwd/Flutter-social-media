import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/usermodel.dart';

import 'package:learning/shared/Cubit/logIn/shoploginstate.dart';

class LoginCubit extends Cubit<SocialLoginStates> {
  LoginCubit() : super(initialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isAppear = true;
  IconData suffix = Icons.visibility_outlined;

  void chanegIcon() {
    isAppear = !isAppear;
    isAppear
        ? suffix = Icons.visibility_outlined
        : suffix = Icons.visibility_off_rounded;
    emit(ChangeIcon());
  }

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
    String image,
    String bio,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
          email: email,
          name: name,
          phone: phone,
          uId: value.user.uid,
          bio: bio,
          image: image);
    }).catchError((onError) {
      emit(SocialRegisterErroeState(onError.toString()));
    });
  }

  var emailAuth = new EmailAuth(
    sessionName: "Social App",
  );

  void sendEmail(String email) async {
    emailAuth.sessionName = 'Social App';
    var res = await emailAuth.sendOtp(recipientMail: email);
    if (res) {
      emit(OTBSendSuccessState());
    } else {
      emit(OTBSendErrorState());
    }
  }

  void verifyOTB(email, userOtp) {
    var res = emailAuth.validateOtp(recipientMail: email, userOtp: userOtp);
    if (res) {
      emit(OTBVerifySuccessState());
    } else {
      emit(OTBVerifyErrorState());
    }
  }

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user.email);

      emit(SocialLoginSuccessState(value.user.uid));
    }).catchError((onError) {
      emit(SocialLoginErroeState(onError.toString()));
    });
  }

  void userCreate({
    @required String email,
    @required String name,
    @required String phone,
    @required String uId,
    @required String image,
    @required String cover,
    @required String bio,
  }) {
    SocialUserModel userModel = SocialUserModel(
        email: email,
        name: name,
        phone: phone,
        uId: uId,
        image: image??'https://image.freepik.com/free-icon/important-person_318-10744.jpg',
        cover: cover??'https://img.freepik.com/free-photo/old-black-background-grunge-texture-dark-wallpaper-blackboard-chalkboard-room-wall_1258-28313.jpg?size=626&ext=jpg',
        bio: bio??' ');

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((onError) {
      emit(SocialCreateUserErroeState(onError.toString()));
    });
  }
}
