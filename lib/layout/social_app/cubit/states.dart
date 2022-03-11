abstract class SocialStates{}
class SocialInitialStates extends SocialStates{}
class SocialGetUserLoadingStates extends SocialStates{}
class SocialGetUserSuccessStates extends SocialStates{}
class SocialGetUserErrorStates extends SocialStates{
  final String error ;
  SocialGetUserErrorStates(this.error);
}

class SocialChangeBottomNavStats extends SocialStates {}