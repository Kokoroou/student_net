import 'package:flutter/material.dart';
import 'package:student_net/settings/settings.dart';

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
                          print('Search Clicked');
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
                    backgroundImage: AssetImage('images/user/sonam.jpg'),
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
                        builder: (context) => SettingsPage(),
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
                  onTap: () => {print('Settings Tapped')},
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
                  onTap: () => {print('Đăng xuất Tapped')},
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
                  onTap: () => {print('Logout Tapped')},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}