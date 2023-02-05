
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_net/models/settings/list_friend_model.dart';
import 'package:student_net/models/settings/logout_model.dart';
import 'package:student_net/pages/auth/login.dart';
import 'package:student_net/pages/main_app/profile_page.dart';
import 'package:student_net/pages/search/search_bar.dart';
import 'package:student_net/pages/settings/settings.dart';
import 'package:student_net/services/api_service.dart';

import '../search/saved_search.dart';

void main() => runApp(const Settings());

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

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
                    icon: Icon(Icons.arrow_back),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(
                    'Menu',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  Container(
                    child: IconButton(
                        icon: Icon(Icons.search),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {

                          showSearch(context: context, delegate: Search());
                        }),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[300]),
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
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    // backgroundImage: AssetImage('images/user/sonam.jpg'),
                  ),
                  title: Text(
                    'Kaito Kuroba',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('View your Profile'),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ),
                    ),
                  },
                ),
                Divider(thickness: 1, color: Colors.black12),
                ListTile(
                  leading: Icon(
                    Icons.book,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Điều khoản và chính sách',
                    style: TextStyle(fontSize: 14),
                  ),
                  onTap: () => {print('Covid Icon Tapped')},
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.grey,
                  ),
                  title: Text(
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
                  leading: Icon(
                    Icons.logout,
                    color: Colors.grey,
                  ),
                  title: Text(
                    'Đăng xuất',
                    style: TextStyle(fontSize: 14),
                  ),
                  onTap: () {
                    LogoutRequestModel model = LogoutRequestModel(
                      token:
                          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzNiZDUyOTgxNTJmZjUzYjI2MDgwNSIsImRhdGVMb2dpbiI6IjIwMjMtMDItMDRUMDM6NDc6MjUuMTkxWiIsImlhdCI6MTY3NTQ4MjQ0NSwiZXhwIjoxNjg1NDgyNDQ0fQ.Wyf8YyLdDG39OiXj3_4WeDGb7JkTLMCF7GBNi0iSqV0",
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                  ),
                  title: Text(
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
