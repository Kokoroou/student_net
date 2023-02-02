import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:student_net/config.dart';
import 'package:student_net/models/auth/login_model.dart';
import 'package:student_net/services/shared_service.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
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

    if (response.statusCode == 200) {
      // SHARED
      await SharedService.setLoginDetails(loginResponseJson(response.body));

      return true;
    } else {
      return false;
    }
  }
}
