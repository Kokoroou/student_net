import 'dart:convert';

class ChangeNameRequestModel {
  String? token;
  String? new_username;

  ChangeNameRequestModel({this.token, this.new_username});

  ChangeNameRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    new_username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['username'] = this.new_username;

    return data;
  }
}

class ChangeNameResponseModel {
  String? code;
  String? message;
  Data? data;
  // String? details;

  ChangeNameResponseModel({this.code, this.message, this.data});

  ChangeNameResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? link;
  String? address;
  String? city;
  String? username;
  String? description;

  Data({this.link, this.address, this.city, this.username, this.description});

  Data.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    address = json['address'];
    city = json['city'];
    username = json['username'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['address'] = this.address;
    data['city'] = this.city;
    data['username'] = this.username;
    data['description'] = this.description;

    return data;
  }
}
