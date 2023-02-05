import 'package:flutter/material.dart';

class Config {
  // App Information
  static const String appName = "Student Net";

  // API Address
  static const String apiURL = "184.169.213.180:3000";
  static const String loginAPI = "/it4788/auth/login";
  static const String setUserInforAPI = "/it4788/user/set_user_info";
  static const String changePasswordAPI = "/it4788/auth/change_password";
  static const String logoutAPI = "/it4788/auth/logout";
  static const String getListFriendsAPI = "/it4788/friend/get_user_friends";
  static const String setBlockAPI = "/it4788/friend/set_block";
  static const String getSavedSearchAPI = "/it4788/search/get_saved_search";
  // // Color palette
  // static const String hexColor1 = "#2B2B2B"; // 2b or not 2b?
  // static const String hexColor2 = "#33516E"; // Tumblr
  // static const String hexColor3 = "#3B5998"; // Facebook
  // static const String hexColor4 = "#20C7FF"; // Twitter
  // static const String hexColor5 = "#E7E8EB"; // White bottom

  // Color palette: https://www.colourlovers.com/palette/148733/Baby_Bingo
  static const String hexColor1 = "#FDD456"; // Creamy
  static const String hexColor2 = "#DE2184"; // Lipstick
  static const String hexColor3 = "#EF218C"; // Rozovo
  static const String hexColor4 = "#F57ABA"; // Blonde's Best Friend
  static const String hexColor5 = "#FFC7E4"; // Rosebud
  static const textColor1 = Colors.white;
  static const textColor2 = Colors.black87;
}
