import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/retry.dart';

class GetSavedSearchRequestModel {
  String? token;
  String? index;
  String? count;

  GetSavedSearchRequestModel({this.token, this.index, this.count});

  GetSavedSearchRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    index = json['index'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['index'] = this.index;
    data['count'] = this.count;

    return data;
  }
}

class GetSavedSearchResponseModel {
  String? code;
  String? message;
  Data? data;

  GetSavedSearchResponseModel({this.code, this.message, this.data});

  GetSavedSearchResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  
  }

  List? getKeywords() {
    if (data == null) {
      return [];
    } else {
      // print(data!.ls_keywords);
      return data!.ls_keywords;
    }
  }
}

class Data {
  List? ls_keywords = [];

  Data({this.ls_keywords});

  Data.fromJson(List<dynamic> list_json) {
    for (var each in list_json) {
      if (each != null) {
        String tmp = each['keyword'].toString();
        if (tmp != null) {
          ls_keywords!.add(tmp);
        }
        // print(each['keyword']);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }
}
