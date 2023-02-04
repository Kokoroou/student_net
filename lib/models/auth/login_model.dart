import 'dart:convert';

class LoginRequestModel {
  String? phonenumber;
  String? password;

  LoginRequestModel({this.phonenumber, this.password});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    phonenumber = json['phonenumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phonenumber'] = this.phonenumber;
    data['password'] = this.password;
    return data;
  }
}

class LoginResponseModel {
  String? code;
  String? message;
  Data? data;
  String? details;

  LoginResponseModel({this.code, this.message, this.data, this.details});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    details = json['details'] != null ? json['details'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.details != null) {
      data['details'] = this.details;
    }
    return data;
  }
}

class Data {
  String? id;
  Null? username;
  String? token;
  Null? avatar;
  Null? active;

  Data({this.id, this.username, this.token, this.avatar, this.active});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    token = json['token'];
    avatar = json['avatar'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['token'] = this.token;
    data['avatar'] = this.avatar;
    data['active'] = this.active;
    return data;
  }
}

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));
