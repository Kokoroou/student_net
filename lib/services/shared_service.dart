import 'dart:convert';
import 'dart:io';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:student_net/models/auth/login_model.dart';
import 'package:student_net/models/auth/signup_model.dart';
import 'package:student_net/models/auth/verify_model.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("data");

    return isKeyExist;
  }

  static Future<LoginResponseModel?> loginDetails() async {
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("data");

    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("data");

      return loginResponseJson(cacheData.syncData);
    }
  }

  static Future<void> setLoginDetails(LoginResponseModel model) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: "data",
      syncData: jsonEncode(model.toJson()),
    );

    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<SignupResponseModel?> signupDetails() async {
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("data");

    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("data");

      return signupResponseJson(cacheData.syncData);
    }
  }

  static Future<void> setSignupDetails(SignupResponseModel model) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: "data",
      syncData: jsonEncode(model.toJson()),
    );

    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<GetVerifyResponseModel?> getVerifyDetails() async {
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("data");

    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("data");

      return getVerifyResponseJson(cacheData.syncData);
    }
  }

  static Future<void> setGetVerifyDetails(GetVerifyResponseModel model) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: "data",
      syncData: jsonEncode(model.toJson()),
    );

    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<CheckVerifyResponseModel?> checkVerifyDetails() async {
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("data");

    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("data");

      return checkVerifyResponseJson(cacheData.syncData);
    }
  }

  static Future<void> setCheckVerifyDetails(
      CheckVerifyResponseModel model) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: "data",
      syncData: jsonEncode(model.toJson()),
    );

    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("data");
    Navigator.pushNamedAndRemoveUntil(
      context,
      "/login",
      (route) => false,
    );
  }
}
