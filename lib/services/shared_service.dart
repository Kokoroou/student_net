import 'dart:convert';
import 'dart:io';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:student_net/models/auth/login_model.dart';
import 'package:student_net/models/auth/signup_model.dart';
import 'package:student_net/models/auth/verify_model.dart';
import 'package:student_net/models/user/info_model.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("data");

    return isKeyExist;
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("data");
    Navigator.pushNamedAndRemoveUntil(
      context,
      "/login",
      (route) => false,
    );
  }

  static Future<void> cacheResponseDetails(
      String response, String requestModelType) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: requestModelType,
      syncData: response,
    );

    await APICacheManager().addCacheData(cacheDBModel);
  }
}
