import 'dart:convert';

class LogoutRequestModel {
  String? token;


  LogoutRequestModel({this.token});

  LogoutRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;

    return data;
  }
}

class LogoutResponseModel {
  String? code;
  String? message;
  String? details;
  // String? details;

  LogoutResponseModel({this.code, this.message, this.details});

  LogoutResponseModel.fromJson(Map<String, dynamic> json) {
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

