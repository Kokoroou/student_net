import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:student_net/config.dart';
import 'package:student_net/models/settings/list_friend_model.dart';
import 'package:student_net/models/settings/logout_model.dart';
import 'package:student_net/models/settings/user_model.dart';
import 'package:student_net/models/user/info_model.dart';
import 'package:student_net/pages/auth/login.dart';
import 'package:student_net/pages/main_app/profile_page.dart';
import 'package:student_net/pages/search/search_bar.dart';
import 'package:student_net/pages/settings/settings.dart';
import 'package:student_net/services/api_service.dart';

import '../search/saved_search.dart';

// void main() => runApp(const Settings());

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // const Settings({Key? key}) : super(key: key);
  Map? loginData = {};
  Map? profile = {};

  getInfo() async {
    await APIService.readCached("LoginRequestModel").then((response) {
      setState(() {
        loginData = response;
      });
    });

    GetInfoRequestModel model1 = GetInfoRequestModel(
        token: loginData!["token"], userId: loginData!["id"]);

    await APIService.getInfo(model1).then((response) {
      setState(() {
        profile = response["data"];
      });
    });
  }

  _SettingsState() {
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 100,
            child: DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    'Menu',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[300]),
                    child: IconButton(
                        icon: const Icon(Icons.search),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          showSearch(context: context, delegate: Search());
                        }),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              image: NetworkImage((loginData!["avatar"] != null)
                                  ? loginData!["avatar"]
                                  : "https://images.pexels.com/photos/69932/tabby-cat-close-up-portrait-69932.jpeg?auto=compress&cs=tinysrgb&w=600"),
                              fit: BoxFit.cover))),
                  title: Text(
                    (profile!["username"] != null) ? profile!["username"] : '',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('View your Profile'),
                  onTap: () => {
                    Navigator.pop(context),
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const ProfilePage(),
                    //   ),
                    // ),
                  },
                ),
                const Divider(thickness: 1, color: Colors.black12),
                ListTile(
                  leading: const Icon(
                    Icons.book,
                    color: Colors.red,
                  ),
                  title: const Text(
                    'Điều khoản và chính sách',
                    style: TextStyle(fontSize: 14),
                  ),
                  onTap: () => {
                    FormHelper.showSimpleAlertDialog(context, Config.appName,
                        "Hiện chưa hỗ trợ tính năng này!", "OK", () {
                      Navigator.pop(context);
                    })
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'Settings',
                    style: TextStyle(fontSize: 14),
                  ),
                  onTap: () {
                    print('Settings Tapped');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SettingsPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'Đăng xuất',
                    style: TextStyle(fontSize: 14),
                  ),
                  onTap: () {
                    LogoutRequestModel model = LogoutRequestModel(
                      token: UserModel.token,
                    );

                    APIService.logout(model).then((response) {
                      if (response == 200) {
                        print("logout success");
                      } else {
                        print("logout ");
                        print(response);
                      }
                      ;
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                  ),
                  title: const Text(
                    'Thoát ứng dụng',
                    style: TextStyle(fontSize: 14),
                  ),
                  onTap: () {
                    SystemNavigator.pop();
                    exit(0);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
