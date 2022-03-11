class SocialUserModel
{
  String? name ;
  String? phone ;
  String? email ;
  String? uId ;

  SocialUserModel({
    this.name,
    this.phone,
    this.email,
    this.uId,
});

  SocialUserModel.fromJson(Map<String,dynamic> json ){
    name =json['name'];
    phone =json['phone'];
    email =json['email'];
    uId =json['uId'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'phone':phone,
      'email':email,
      'uId':uId,
    };
  }
}