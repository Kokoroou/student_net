import 'dart:convert';

class ChangePassRequestModel {
  String? token;
  String? password;
  String? new_password;

  ChangePassRequestModel({this.token, this.password, this.new_password});

  ChangePassRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    this.password = json['password'];
    this.new_password = json['new_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['password'] = this.password;
    data['new_password'] = this.new_password;

    return data;
  }
}

class ChangePassResponseModel {
  String? code;
  String? message;
  String? details;
  // String? details;

  ChangePassResponseModel({this.code, this.message, this.details});

  ChangePassResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    details = json['details'] != null ? json['details'] : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['code'] = this.code;
    data['message'] = this.message;
    if (this.details != null) {
      data['details'] = this.details!;
    }

    return data;
  }
}

