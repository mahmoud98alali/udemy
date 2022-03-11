class PostModel
{
  String? name ;
  String? uId ;
  String? image ;
  String? dateTime ;
  String? text ;
  String? postImage ;
  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
  });

  PostModel.fromJson(Map<String,dynamic> json ){
    name =json['name'];
    postImage =json['postImage'];
    text =json['text'];
    uId =json['uId'];
    dateTime =json['dateTime'];
    image =json['image'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'postImage':postImage,
      'text':text,
      'dateTime':dateTime,
      'uId':uId,
      'image':image,
    };
  }
}