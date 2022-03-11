class SocialUserModel
{
  String? name ;
  String? phone ;
  String? email ;
  String? uId ;
  String? image ;
  String? cover ;
  String? bio ;
  bool? isEmailVerified;
  SocialUserModel({
    this.name,
    this.phone,
    this.email,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String,dynamic> json ){
    name =json['name'];
    phone =json['phone'];
    email =json['email'];
    uId =json['uId'];
    bio =json['bio'];
    cover =json['cover'];
    image =json['image'];
    isEmailVerified =json['isEmailVerified'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'phone':phone,
      'email':email,
      'uId':uId,
      'bio':bio,
      'cover':cover,
      'image':image,
      'isEmailVerified':isEmailVerified,
    };
  }
}