import "dart:convert";

import 'package:flutter/material.dart';
import 'package:student_net/pages/friend/list_friend.dart';

class GetListFriendsRequestModel {
  String? token;
  String? user_id;
  String? index;
  String? count;
  String? page;

  GetListFriendsRequestModel(
      {this.token, this.user_id, this.index, this.count, this.page});

  GetListFriendsRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user_id = json['user_id'];
    index = json['index'];
    count = json['count'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['user_id'] = this.user_id;
    data['index'] = this.index;
    data['count'] = this.count;
    data['page'] = this.page;

    return data;
  }
}

class GetListFriendsResponseModel {
  String? code;
  String? message;
  Data? data;

  GetListFriendsResponseModel({this.code, this.message, this.data});

  GetListFriendsResponseModel.fromJson(Map<String, dynamic> json){
    code = json['code'];

    message = json['message']; 
    // data= null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;

  }
  List? getFriends(){
    if (data == null){
      return [];
    }
    else{
      return data?.ls_friends;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    // data['code'] = this.code;
    // data['message'] = this.message;

    // if (this.data != null){
    //   data['data'] = this.data!.toJson();
    // }

    return data;
  }


}

class Data {
  List? ls_friends = [];
  String? total;

  Data({this.ls_friends, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    // {'friends' : [], total: 12}

    for (var each in json['friends']) {
      if (each != null) {
        ls_friends!.add(new Friends.fromJson(each));
      }
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    // data['friends'] = this.ls_friends;
    // data['total'] = this.total;

    return data;
  }
}

class Friends {
  String? user_id;
  String? user_name;
  String? same_friends;

  Friends({this.user_id, this.user_name, this.same_friends});

  String? getUserName(){
    return user_name;
  }
  String? getSameFriends(){
    return same_friends;
  }
  String? getUserId(){
    return user_id;
  }
  Friends.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    user_name = json['username'];
    same_friends = json['same_friends'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['user_id'] = this.user_id;
    data['username'] = this.user_name;
    data['same_friends'] = this.same_friends;

    return data;
  }
  
}
