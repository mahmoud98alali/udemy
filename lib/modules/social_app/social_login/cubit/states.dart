

abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}
class SocialLoginLoadingState extends SocialLoginStates {}
class SocialLoginSuccessState extends SocialLoginStates {

}
class SocialLoginErrorState extends SocialLoginStates {
  final String error;
  SocialLoginErrorState(this.error);
}

class SocialChangePasswordVisibilityState extends SocialLoginStates {}
