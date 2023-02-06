import 'dart:convert';

class SignupRequestModel {
  String? phonenumber;
  String? password;

  SignupRequestModel({this.phonenumber, this.password});

  SignupRequestModel.fromJson(Map<String, dynamic> json) {
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

class SignupResponseModel {
  String? code;
  String? message;
  Data? data;

  SignupResponseModel({this.code, this.message, this.data});

  SignupResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? id;
  String? phoneNumber;
  String? verifyCode;
  String? isVerified;

  Data({this.id, this.phoneNumber, this.verifyCode, this.isVerified});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    verifyCode = json['verifyCode'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phoneNumber'] = this.phoneNumber;
    data['verifyCode'] = this.verifyCode;
    data['isVerified'] = this.isVerified;
    return data;
  }
}

SignupResponseModel signupResponseJson(String str) =>
    SignupResponseModel.fromJson(json.decode(str));
