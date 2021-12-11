
abstract class SocialLoginStates {}

class initialState extends SocialLoginStates{}
class ChangeIcon extends SocialLoginStates{}


class SocialLoginSuccessState extends SocialLoginStates {
  final uId;

  SocialLoginSuccessState(this.uId);
}
class SocialLoginLoadingState extends SocialLoginStates{}
class SocialLoginErroeState extends SocialLoginStates{
  final error;

  SocialLoginErroeState(this.error);
}

class SocialRegisterSuccessState extends SocialLoginStates {}
class SocialRegisterLoadingState extends SocialLoginStates{}
class SocialRegisterErroeState extends SocialLoginStates{
  final error;

  SocialRegisterErroeState(this.error);
}


class SocialCreateUserSuccessState extends SocialLoginStates {

}
class SocialCreateUserErroeState extends SocialLoginStates{
  final error;

  SocialCreateUserErroeState(this.error);
}


class OTBSendSuccessState extends SocialLoginStates {}
class OTBSendErrorState extends SocialLoginStates{}
class OTBVerifySuccessState extends SocialLoginStates {}
class OTBVerifyErrorState extends SocialLoginStates{}