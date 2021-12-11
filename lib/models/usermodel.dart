class SocialUserModel {
  String name;
  String email;
  String phone;
  String bio;
  String image;
  String cover;
  String uId;

  SocialUserModel({this.email, this.name, this.phone, this.uId , this.bio , this.image, this.cover});

  SocialUserModel.fromJson(Map<String , dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    bio = json['Bio'];
    image = json['image'];
    cover = json['cover'];
    uId = json['uId'];
  }

  Map<String , dynamic> toMap()
  {
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'Bio':bio,
      'image':image,
      'cover':cover,
      'uId':uId,
    };
  }
}