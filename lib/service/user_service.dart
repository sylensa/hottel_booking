// To parse this JSON data, do
//
//     final getFan = getFanFromJson(jsonString);

import 'dart:convert';

UserService getFanFromJson(String str) => UserService.fromJson(json.decode(str));

String getFanToJson(UserService data) => json.encode(data.toJson());

class UserService {
  UserService({
    this.status,
    this.data,
  });

  bool status;
  List<UserInfos> data;


  factory UserService.fromJson(Map<String, dynamic> json) => UserService(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<UserInfos>.from(json["data"].map((x) => UserInfos.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}



class UserInfos {
  UserInfos({
    this.mobile,
    this.fullname,
    this.active,
    this.country,
    this.online,
    this.lastSeen,
    this.userType,
    this.appVers,
    this.status,
    this.image,
  });

  String mobile;
  String fullname;
  String active;
  String country;
  String online;
  String lastSeen;
  String userType;
  String appVers;
  String status;
  String image;

  factory UserInfos.fromJson(Map<String, dynamic> json) => UserInfos(
    mobile: json["mobile"] == null ? null : json["mobile"],
    fullname: json["fullname"] == null ? null : json["fullname"],
    active: json["active"] == null ? null : json["active"],
    country: json["country"] == null ? null :json["country"],
    online: json["online"] == null ? null : json["online"],
    lastSeen: json["last_seen"] == null ? null : json["last_seen"],
    userType: json["user_type"] == null ? null : json["user_type"],
    appVers: json["app_vers"] == null ? null : json["app_vers"],
    status: json["status"] == null ? null : json["status"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile == null ? null : mobile,
    "fullname": fullname == null ? null : fullname,
    "active": active == null ? null : active,
    "country": country == null ? null : country,
    "online": online == null ? null : online,
    "last_seen": lastSeen == null ? null : lastSeen,
    "user_type": userType == null ? null : userType,
    "app_vers": appVers == null ? null : appVers,
    "status": status == null ? null : status,
    "image": image == null ? null : image,
  };
}







