import 'dart:convert';
import 'dart:io';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_db_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:student_net/config.dart';
import 'package:student_net/models/auth/login_model.dart';
import 'package:student_net/models/auth/signup_model.dart';
import 'package:student_net/models/auth/verify_model.dart';
import 'package:student_net/models/post/interact_post_model.dart';
import 'package:student_net/models/post/list_post_model.dart';
import 'package:student_net/models/search/del_search_model.dart';
import 'package:student_net/models/search/saved_search_model.dart';
import 'package:student_net/models/settings/change_name_model.dart';
import 'package:student_net/models/settings/change_pass_model.dart';
import 'package:student_net/models/settings/list_friend_model.dart';
import 'package:student_net/models/settings/logout_model.dart';
import 'package:student_net/models/settings/set_block.model.dart';
import 'package:student_net/models/user/info_model.dart';
import 'package:student_net/services/shared_service.dart';

class APIService {
  static var client = http.Client();

  static Future<Map> readCached(String requestModelType) async {
    // List<Map<String, dynamic>> database = await APICacheDBHelper.rawQuery(
    //     "select * from ${APICacheDBModel.table}");
    // print("---database:$database");

    String query =
        "select syncData from ${APICacheDBModel.table} where key='$requestModelType'";
    List<Map<String, dynamic>> cachedData =
        await APICacheDBHelper.rawQuery(query);

    // print("----query: $query");
    // print("----cachedData:$cachedData");

    Map data = jsonDecode(cachedData[0]["syncData"])["data"];

    return data;
  }

  // static Future<Map<String, dynamic>> _readFile(String filePath) async {
  //   final file = File(filePath);
  //   final jsonStr = await file.readAsString();

  //   return jsonDecode(jsonStr) as Map<String, dynamic>;
  // }

  // static Future<void> _writeFile(
  //     Map<String, dynamic> map, String filePath) async {
  //   final jsonStr = jsonEncode(map);

  //   final file = File(filePath);

  //   await file.writeAsString(jsonStr);
  // }

  static Future<bool> change_name(ChangeNameRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var body = model.toJson();
    var url = Uri.http(Config.apiURL, Config.setUserInfoAPI, body);

    var response = await client.post(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<int> change_password(ChangePassRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var body = model.toJson();
    var url = Uri.http(Config.apiURL, Config.changePasswordAPI, body);

    var response = await client.post(url, headers: requestHeaders);
    return response.statusCode;
  }

  static Future<int> set_block(SetBlockRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var body = model.toJson();
    var url = Uri.http(Config.apiURL, Config.setBlockAPI, body);

    var response = await client.post(url, headers: requestHeaders);
    return response.statusCode;
  }

  static Future get_ls_friends(GetListFriendsRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var body = model.toJson();
    var url = Uri.http(Config.apiURL, Config.getListFriendsAPI, body);

    var response = await client.post(url, headers: requestHeaders);
    return response;
  }

  static Future get_ls_keywords(GetSavedSearchRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var body = model.toJson();
    var url = Uri.http(Config.apiURL, Config.getSavedSearchAPI, body);

    var response = await client.post(url, headers: requestHeaders);
    return response;
  }

  static Future<int> logout(LogoutRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var body = model.toJson();
    var url = Uri.http(Config.apiURL, Config.logoutAPI, body);

    var response = await client.post(url, headers: requestHeaders);
    return response.statusCode;
  }

  static Future<Map> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var body = model.toJson();

    // Add body in url because server do not wait for body [Server error]
    var url = Uri.http(Config.apiURL, Config.loginAPI, body);

    var response = await client.post(
      url,
      headers: requestHeaders,
    );

    // print("--------------Request: ${response.request}");
    // print("--------------response.statusCode: ${response.statusCode}");
    // print("--------------response.body: ${response.body}");

    if (response.statusCode == 200) {
      await SharedService.cacheResponseDetails(
          response.body, model.runtimeType.toString());
    }
    return jsonDecode(response.body);
  }

  static Future<Map> signup(SignupRequestModel model) async {
    var body = model.toJson();

    // Add body in url because server do not wait for body [Server error]
    var url = Uri.http(Config.apiURL, Config.signupAPI, body);

    var response = await client.post(
      url,
    );

    // print("--------------Request: ${response.request}");
    // print("--------------response.statusCode: ${response.statusCode}");
    // print("--------------response.body: ${response.body}");

    if (response.statusCode == 200) {
      await SharedService.cacheResponseDetails(
          response.body, model.runtimeType.toString());
    }
    return jsonDecode(response.body);
  }

  static Future<Map> getVerify(GetVerifyRequestModel model) async {
    var body = model.toJson();

    // Add body in url because server do not wait for body [Server error]
    var url = Uri.http(Config.apiURL, Config.getVerifyCodeAPI, body);

    var response = await client.post(
      url,
    );

    // print("--------------Request: ${response.request}");
    // print("--------------response.statusCode: ${response.statusCode}");
    // print("--------------response.body: ${response.body}");

    if (response.statusCode == 200) {
      await SharedService.cacheResponseDetails(
          response.body, model.runtimeType.toString());
    }
    return jsonDecode(response.body);
  }

  static Future<Map> checkVerify(CheckVerifyRequestModel model) async {
    var body = model.toJson();

    // Add body in url because server do not wait for body [Server error]
    var url = Uri.http(Config.apiURL, Config.checkVerifyCodeAPI, body);

    var response = await client.post(
      url,
    );

    // print("--------------Request: ${response.request}");
    // print("--------------response.statusCode: ${response.statusCode}");
    // print("--------------response.body: ${response.body}");

    if (response.statusCode == 200) {
      await SharedService.cacheResponseDetails(
          response.body, model.runtimeType.toString());
    }
    return jsonDecode(response.body);
  }

  static Future<Map> getInfo(GetInfoRequestModel model) async {
    var body = model.toJson();

    // Add body in url because server do not wait for body [Server error]
    var url = Uri.http(Config.apiURL, Config.getUserInfoAPI, body);

    var response = await client.post(
      url,
    );

    // print("--------------Request: ${response.request}");
    // print("--------------response.statusCode: ${response.statusCode}");
    // print("--------------response.body: ${response.body}");

    if (response.statusCode == 200) {
      await SharedService.cacheResponseDetails(
          response.body, model.runtimeType.toString());
    }
    return jsonDecode(response.body);
  }

  static Future<Map> setInfo(SetInfoRequestModel model) async {
    var body = model.toJson();

    // Add body in url because server do not wait for body [Server error]
    var url = Uri.http(Config.apiURL, Config.setUserInfoAPI, body);

    var response = await client.post(
      url,
    );

    // print("--------------Request: ${response.request}");
    // print("--------------response.statusCode: ${response.statusCode}");
    // print("--------------response.body: ${response.body}");

    if (response.statusCode == 200) {
      await SharedService.cacheResponseDetails(
          response.body, model.runtimeType.toString());
    }
    return jsonDecode(response.body);
  }

  static Future<Map> addPost(AddPostRequestModel model) async {
    var body = model.toJson();

    // Add body in url because server do not wait for body [Server error]
    var url = Uri.http(Config.apiURL, Config.addPostAPI, body);

    var response = await client.post(
      url,
    );

    // print("--------------Request: ${response.request}");
    // print("--------------response.statusCode: ${response.statusCode}");
    // print("--------------response.body: ${response.body}");

    if (response.statusCode == 200) {
      await SharedService.cacheResponseDetails(
          response.body, model.runtimeType.toString());
    }
    return jsonDecode(response.body);
  }

  static Future<Map> getPost(GetPostRequestModel model) async {
    var body = model.toJson();

    // Add body in url because server do not wait for body [Server error]
    var url = Uri.http(Config.apiURL, Config.getPostAPI, body);

    var response = await client.post(
      url,
    );

    // print("--------------Request: ${response.request}");
    // print("--------------response.statusCode: ${response.statusCode}");
    // print("--------------response.body: ${response.body}");

    if (response.statusCode == 200) {
      await SharedService.cacheResponseDetails(
          response.body, model.runtimeType.toString());
    }
    return jsonDecode(response.body);
  }

  static Future<Map> editPost(EditPostRequestModel model) async {
    var body = model.toJson();

    // Add body in url because server do not wait for body [Server error]
    var url = Uri.http(Config.apiURL, Config.editPostAPI, body);

    var response = await client.post(
      url,
    );

    // print("--------------Request: ${response.request}");
    // print("--------------response.statusCode: ${response.statusCode}");
    // print("--------------response.body: ${response.body}");

    if (response.statusCode == 200) {
      await SharedService.cacheResponseDetails(
          response.body, model.runtimeType.toString());
    }
    return jsonDecode(response.body);
  }

  static Future<Map> deletePost(DeletePostRequestModel model) async {
    var body = model.toJson();

    // Add body in url because server do not wait for body [Server error]
    var url = Uri.http(Config.apiURL, Config.deletePostAPI, body);

    var response = await client.post(
      url,
    );

    // print("--------------Request: ${response.request}");
    // print("--------------response.statusCode: ${response.statusCode}");
    // print("--------------response.body: ${response.body}");

    if (response.statusCode == 200) {
      await SharedService.cacheResponseDetails(
          response.body, model.runtimeType.toString());
    }
    return jsonDecode(response.body);
  }

  static Future<Map> getListPosts(ListPostsRequestModel model) async {
    var body = model.toJson();

    // Add body in url because server do not wait for body [Server error]
    var url = Uri.http(Config.apiURL, Config.getListPostsAPI, body);

    var response = await client.post(
      url,
    );

    // print("--------------Request: ${response.request}");
    // print("--------------response.statusCode: ${response.statusCode}");
    // print("--------------response.body: ${response.body}");

    if (response.statusCode == 200) {
      await SharedService.cacheResponseDetails(
          response.body, model.runtimeType.toString());
    }
    return jsonDecode(response.body);
  }

  static Future<Map> getListVideos(ListVideosRequestModel model) async {
    var body = model.toJson();

    // Add body in url because server do not wait for body [Server error]
    var url = Uri.http(Config.apiURL, Config.getListVideosAPI, body);

    var response = await client.post(
      url,
    );

    // print("--------------Request: ${response.request}");
    // print("--------------response.statusCode: ${response.statusCode}");
    // print("--------------response.body: ${response.body}");

    if (response.statusCode == 200) {
      await SharedService.cacheResponseDetails(
          response.body, model.runtimeType.toString());
    }
    return jsonDecode(response.body);
  }

  static Future<Map> getListInProfile(ListInProfileRequestModel model) async {
    var body = model.toJson();

    // Add body in url because server do not wait for body [Server error]
    var url = Uri.http(Config.apiURL, Config.getListPostsInProfileAPI, body);

    var response = await client.post(
      url,
    );

    // print("--------------Request: ${response.request}");
    // print("--------------response.statusCode: ${response.statusCode}");
    // print("--------------response.body: ${response.body}");

    if (response.statusCode == 200) {
      await SharedService.cacheResponseDetails(
          response.body, model.runtimeType.toString());
    }
    return jsonDecode(response.body);
  }
}
