import 'package:flutter/material.dart';

class Config {
  // App Information
  static const String appName = "Student Network";

  // API Address
  static const String apiURL = "184.169.213.180:3000";

  static const String loginAPI = "/it4788/auth/login";
  static const String signupAPI = "/it4788/auth/signup";
  static const String getVerifyCodeAPI = "/it4788/auth/get_verify_code";
  static const String checkVerifyCodeAPI = "/it4788/auth/check_verify_code";
  static const String changePasswordAPI = "/it4788/auth/change_password";
  static const String logoutAPI = "/it4788/auth/logout";

  static const String getUserInfoAPI = "/it4788/user/get_user_info";
  static const String setUserInfoAPI = "/it4788/user/set_user_info";

  static const String addPostAPI = "/it4788/post/add_post";
  static const String getPostAPI = "/it4788/post/get_post";
  static const String editPostAPI = "/it4788/post/edit_post";
  static const String deletePostAPI = "/it4788/post/delete_post";
  // static const String reportPostAPI = "/it4788/post/report_post";
  // static const String checkNewItem = "/it4788/post/check_new_item";
  static const String getListPostsAPI = "/it4788/post/get_list_posts";
  static const String getListVideosAPI = "/it4788/post/get_list_videos";
  static const String getListPostsInProfileAPI =
      "/it4788/post/get_list_posts_in_profile";

  static const String getListFriendsAPI = "/it4788/friend/get_user_friends";
  static const String setBlockAPI = "/it4788/friend/set_block";
  static const String getListBlocksAPI = "/it4788/friend/get_list_blocks";

  static const String getSavedSearchAPI = "/it4788/search/get_saved_search";
  static const String delSavedSearchAPI = "/it4788/search/del_saved_search";

  // Color palette: https://www.colourlovers.com/palette/148733/Baby_Bingo
  static const hexColor1 = Color(0xFFFDD456); // Creamy
  static const hexColor2 = Color(0xFFDE2184); // Lipstick
  static const hexColor3 = Color(0xFFEF218C); // Rozovo
  static const hexColor4 = Color(0xFFF57ABA); // Blonde's Best Friend
  static const hexColor5 = Color(0xFFFFC7E4); // Rosebud
  static const textColor1 = Colors.white;
  static const textColor2 = Colors.black87;
}
