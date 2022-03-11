class SocialUserModel
{
  String? name ;
  String? phone ;
  String? email ;
  String? uId ;
  bool? isEmailVerified;
  SocialUserModel({
    this.name,
    this.phone,
    this.email,
    this.uId,
    this.isEmailVerified,
});

  SocialUserModel.fromJson(Map<String,dynamic> json ){
    name =json['name'];
    phone =json['phone'];
    email =json['email'];
    uId =json['uId'];
    isEmailVerified =json['isEmailVerified'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'phone':phone,
      'email':email,
      'uId':uId,
      'isEmailVerified':isEmailVerified,
    };
  }
}