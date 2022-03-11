abstract class SocialStates{}
class SocialInitialStates extends SocialStates{}
class SocialGetUserLoadingStates extends SocialStates{}
class SocialGetUserSuccessStates extends SocialStates{}
class SocialGetUserErrorStates extends SocialStates{
  final String error ;
  SocialGetUserErrorStates(this.error);
}

class SocialChangeBottomNavStats extends SocialStates {}
class SocialNewPostStats extends SocialStates {}
class SocialProfileImagePickedSuccessStats extends SocialStates {}
class SocialProfileImagePickedErrorStats extends SocialStates {}
class SocialCoverImagePickedSuccessStats extends SocialStates {}
class SocialCoverImagePickedErrorStats extends SocialStates {}

class SocialUploadProfileImageSuccessStats extends SocialStates {}
class SocialUploadProfileImageErrorStats extends SocialStates {}
class SocialUploadCoverImageSuccessStats extends SocialStates {}
class SocialUploadCoverImageErrorStats extends SocialStates {}
class SocialUserUpdateErrorStats extends SocialStates {}
class SocialUserUpdateLoadingStats extends SocialStates {}
class SocialUserUpdateProfileLoadingStats extends SocialStates {}
class SocialUserUpdateCoverLoadingStats extends SocialStates {}

// Create Post
class SocialCreatePostLoadingStats extends SocialStates {}
class SocialCreatePostSuccessStats extends SocialStates {}
class SocialCreatePostErrorStats extends SocialStates {}

class SocialPostImagePickedSuccessStats extends SocialStates {}
class SocialPostImagePickedErrorStats extends SocialStates {}
class SocialRemoveImagePickedStats extends SocialStates {}


// Get Post

class SocialGetPostsLoadingStates extends SocialStates{}
class SocialGetPostsSuccessStates extends SocialStates{}
class SocialGetPostsErrorStates extends SocialStates{
  final String error ;
  SocialGetPostsErrorStates(this.error);
}


// Like Post
class SocialLikePostSuccessStates extends SocialStates{}
class SocialLikePostErrorStates extends SocialStates{
  final String error ;
  SocialLikePostErrorStates(this.error);
}


// Comments
// Like Post
class SocialCommentsPostSuccessStates extends SocialStates{}
class SocialCommentsPostErrorStates extends SocialStates{
  final String error ;
  SocialCommentsPostErrorStates(this.error);
}
