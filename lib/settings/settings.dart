import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_net/settings/block.dart';
import 'package:student_net/settings/change_name.dart';
import 'package:student_net/settings/change_password.dart';


void main() => runApp(SettingsPage());

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<bool> _status = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: ListView(
            children: [
              Text("Settings",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Icon(Icons.person, color: Colors.blue),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Account & Security",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              buildAccountOptions(context, "Change Name", EditNamePage()),
              buildAccountOptions(context, "Change Password", EditPassPage()),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Icon(Icons.block, color: Colors.blue),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Quyền riêng tư",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              buildAccountOptions(context, "Chặn", BlockPage()),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Icon(Icons.volume_up_outlined, color: Colors.blue),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Cài đặt thông báo",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              buildNotificationOptions(context, "Thông báo đẩy", 0),
              buildNotificationOptions(context, "Rung", 1),
              buildNotificationOptions(context, "Đèn LED điện thoại", 2),
              buildNotificationOptions(context, "Âm thanh", 3),
            ],
          ),
        ));
  }

  Row buildNotificationOptions(BuildContext context, String name, int index) {


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
                value: _status[index],
                onChanged: (bool val) {
                  print("change");
                  print(val);
                  setState(() {
                    
                  _status[index] = val;
                  });
                })),
      ],
    );
  }

  GestureDetector buildAccountOptions(BuildContext context, String name, var page) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> page));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
