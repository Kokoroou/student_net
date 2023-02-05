import 'dart:convert';

import 'package:student_net/pages/friend/list_friend.dart';

class SetBlockRequestModel{
  String? token;
  String? user_id;
  String? type;

  SetBlockRequestModel({this.token, this.user_id, this.type});

  SetBlockRequestModel.fromJson(Map<String, dynamic> json){
    token = json['token'];
    user_id = json['user_id'];
    type= json['type'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data= new Map<String, dynamic>();

    data['token'] = this.token;
    data['user_id'] = this.user_id;
    data['type'] = this.type;

    return data;
  }
}