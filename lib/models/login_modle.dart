class LoginModel
{
  late bool status;
  late String message;
  late UserData? data;
  LoginModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
    data=json['data']!=null?UserData.fromJson(json['data']):null;
  }
}
class UserData
{
  late int? id;
  late String? name ;
  late String? email;
  late String? phone;
  late String? image;
  late int? points;
  late int? credit;
  late String? token;
  UserData({
    this.id,
    this.name,
    this.email,
    this.image,
    this.points,
    this.credit,
    this.phone,
    this.token
});
//named constructor
  UserData.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    name=json['name'];
    email=json['email'];
    image=json['image'];
    phone=json['phone'];
    points=json['id'];
    token=json['token'];
    credit=json['id'];
  }
}