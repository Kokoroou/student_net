import 'dart:convert';

class GetInfoRequestModel {
  String? token;
  String? userId;

  GetInfoRequestModel({this.token, this.userId});

  GetInfoRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['user_id'] = this.userId;
    return data;
  }
}

class GetInfoResponseModel {
  String? code;
  String? message;
  Data1? data;

  GetInfoResponseModel({this.code, this.message, this.data});

  GetInfoResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data1.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data1 {
  String? id;
  String? created;
  String? description;
  String? listing;
  String? isFriend;
  Null? online;

  Data1(
      {this.id,
      this.created,
      this.description,
      this.listing,
      this.isFriend,
      this.online});

  Data1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    description = json['description'];
    listing = json['listing'];
    isFriend = json['is_friend'];
    online = json['online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['description'] = this.description;
    data['listing'] = this.listing;
    data['is_friend'] = this.isFriend;
    data['online'] = this.online;
    return data;
  }
}

class SetInfoRequestModel {
  String? token;
  String? description;
  String? address;
  String? city;
  String? country;
  String? link;
  String? username;

  SetInfoRequestModel(
      {this.token,
      this.description,
      this.address,
      this.city,
      this.country,
      this.link,
      this.username});

  SetInfoRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    description = json['description'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    link = json['link'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['description'] = this.description;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['link'] = this.link;
    data['username'] = this.username;
    return data;
  }
}

class SetInfoResponseModel {
  String? code;
  String? message;
  Data2? data;

  SetInfoResponseModel({this.code, this.message, this.data});

  SetInfoResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data2.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data2 {
  String? link;
  String? address;
  String? city;
  String? country;
  String? username;
  String? description;

  Data2(
      {this.link,
      this.address,
      this.city,
      this.country,
      this.username,
      this.description});

  Data2.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    username = json['username'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['username'] = this.username;
    data['description'] = this.description;
    return data;
  }
}

// GetInfoResponseModel getInfoResponseJson(String str) =>
//     GetInfoResponseModel.fromJson(json.decode(str));

// SetInfoResponseModel setInfoResponseJson(String str) =>
//     SetInfoResponseModel.fromJson(json.decode(str));
