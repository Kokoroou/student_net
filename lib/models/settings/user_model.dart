import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_net/pages/friend/list_friend.dart';

class UserModel {
  static String? username;
  static String? token;
  static String? avatar;
  static String? id;
  static String? active;

  static Future? readJson() async {
    WidgetsFlutterBinding.ensureInitialized();
    await rootBundle.loadString('assets/temp/cookies.json').then((value) {
      final data = json.decode(value);
      print(data);
      username = data['username'];
      id = data['id'];
      token = data['token'];
      avatar = data['avatar'];
      active = data['activate'];
    });
  }

  static void updateName(String? name) {
    username = name;
  }

  static void updateToken(String? new_token) {
    token = new_token;
  }

  static void udpateID(String? new_id) {
    id = new_id;
  }

  static Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['username'] = username;
    data['token'] = token;
    data['avatar'] = avatar;
    data['active'] = active;
    data['id'] = id;

    return data;
  }

  static void updateAvatar(String? new_avatar) {
    avatar = new_avatar;
  }

  static ImageProvider  getAvatar(){
    if (avatar == null){
      return const AssetImage("assets/favicon.png");
    }
    else{
      print(UserModel.avatar);
      return  NetworkImage(UserModel.avatar!);
    }
  }

}
