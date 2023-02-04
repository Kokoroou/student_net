import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_net/search/search_bar.dart';

void main() => runApp(const ListFriends());

class ListFriends extends StatelessWidget {
  const ListFriends({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Danh sách bạn bè"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
        ),
        body: Container(
            child: Stack(
          children: <Widget>[
            Column(children: <Widget>[
              History(),
              // History(),
            ]),
          ],
        )));
  }
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 40,
              color: Colors.white,
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Bạn bè',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                          child: Text(
                            'Sắp xếp',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            MyListPage(),
          ],
        )
      ],
    );
  }
}

class MyListPage extends StatefulWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  List<String> data = ["1", "2", "3", "4"];
  get_list_blocks() async {
    var response = await http.post(
      Uri.parse(
        "http://184.169.213.180:3000/it4788/friend/get_list_blocks/",
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token':
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzNiZDUyOTgxNTJmZjUzYjI2MDgwNSIsImRhdGVMb2dpbiI6IjIwMjMtMDItMDFUMTI6NTc6MTYuODM3WiIsImlhdCI6MTY3NTI1NjIzNywiZXhwIjoxNjg1MjU2MjM2fQ.AafjbzuumSE915Om3JoD1qLuyhJbtVJDD1A9aLVHpBc",
        "index": "0",
        "count": "5",
      }),
    );
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    get_list_blocks();
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: ((context, index) {
        return Card(
            // color: Color.fromARGB(255, 230, 227, 227),
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(data[index]),
                  leading: CircleAvatar(
                    radius: 30,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/favicon.png"),
                      // backgroundImage: NetworkImage(avatarUrl),
                      radius: 25.0,
                      // backgroundColor: Colors.black,
                    ),
                    // backgroundColor: Colors.white,
                  ),
                  trailing: Container(
                    width: 20,
                    child: Row(
                      children: [
                        Expanded(
                            child: IconButton(
                          icon: Icon(Icons.more_horiz),
                          onPressed: () {
                            print("show pop up of this friends");
                            _showMoreOption(context);
                          },
                        )),
                      ],
                    ),
                  ),
                )));
      }),
    );
  }

  _showMoreOption(context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.chat,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Nhắn tin',
                        style: TextStyle(fontSize: 18.0),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.block,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Chặn',
                        style: TextStyle(fontSize: 18.0),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.person_remove_outlined,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Hủy kết bạn',
                        style: TextStyle(fontSize: 18.0, color: Colors.red),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}