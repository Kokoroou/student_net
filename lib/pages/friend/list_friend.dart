import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_net/models/settings/list_friend_model.dart';
import 'package:student_net/models/settings/set_block.model.dart';
import 'package:student_net/models/settings/user_model.dart';
import 'package:student_net/pages/main_app/chat_page.dart';
import 'package:student_net/pages/search/search_bar.dart';
import 'package:student_net/services/api_service.dart';

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

class user {
  String? username;
  int? same_friends;
}

class _MyListPageState extends State<MyListPage> {
  List? data = [];

  @override
  Widget build(BuildContext context) {
    GetListFriendsRequestModel model = GetListFriendsRequestModel(
      token: UserModel.token,
      user_id: UserModel.id,
      count: "10",
      index: "0",
      page: "1",
    );

    // APIService.get_ls_friends(model).then((value) {
    //   GetListFriendsResponseModel response =
    //       GetListFriendsResponseModel.fromJson(json.decode(value.body));
    //   // print(response.toJson()['data']['total']);
    //   // print(response.getFriends()?.length);
    //   if (this.mounted) {
    //     setState(() {
    //       this.data = response.getFriends();
    //     });
    //   }
    // });

    return FutureBuilder(
        future: APIService.get_ls_friends(model),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
                  GetListFriendsResponseModel response =
          GetListFriendsResponseModel.fromJson(json.decode(snapshot.data.body));
          data = response.getFriends();
          
            return ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: data?.length,
              itemBuilder: ((context, index) {
                return Card(
                    // color: Color.fromARGB(255, 230, 227, 227),
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(data!.elementAt(index).getUserName()),
                          leading: CircleAvatar(
                            radius: 30,
                            child: CircleAvatar(
                              backgroundImage: UserModel.getAvatar(),
                              // backgroundImage: NetworkImage(avatarUrl),
                              radius: 25.0,
                              // backgroundColor: Colors.black,
                            ),
                            // backgroundColor: Colors.white,
                          ),
                          subtitle: Text(
                              data!.elementAt(index).getSameFriends() +
                                  " bạn chung"),
                          trailing: Container(
                            width: 20,
                            child: Row(
                              children: [
                                Expanded(
                                    child: IconButton(
                                  icon: Icon(Icons.more_horiz),
                                  onPressed: () {
                                    print("show pop up of this friends");
                                    _showMoreOption(context, index,
                                        data!.elementAt(index).getUserId());
                                  },
                                )),
                              ],
                            ),
                          ),
                        )));
              }),
            );
          } else {

            return Center(child: CircularProgressIndicator());
          
          
          }
        });
  }

  _showMoreOption(context, int index, String user_id) {
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
                TextButton(
                    onPressed: () {},
                    child: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          print("Chaating");
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.person_remove_outlined,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Chat',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: 1,
                ),
                TextButton(
                    onPressed: () {
                      SetBlockRequestModel model = SetBlockRequestModel(
                          token: UserModel.token,
                          user_id: UserModel.id,
                          type: "1");

                      APIService.set_block(model).then((value) {
                        print(value);
                        if (value == 200) {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Thông báo'),
                                    content: const Text('Đã chặn thành công'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'OK');
                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                        }
                      });
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatPage()));
                        },
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
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: 1,
                ),
                TextButton(
                    onPressed: () {},
                    child: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          print("Huy ket ban");
                        },
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
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ))
                // Container(
                //   padding: EdgeInsets.all(10.0),
                //   child: GestureDetector(
                //     onTap: (){
                //       print("Huy ket ban");
                //     },
                //     child: Row(
                //       children: <Widget>[
                //         Icon(
                //           Icons.person_remove_outlined,
                //           color: Colors.red,
                //         ),
                //         SizedBox(
                //           width: 10.0,
                //         ),
                //         Text(
                //           'Hủy kết bạn',
                //           style: TextStyle(fontSize: 18.0, color: Colors.red),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
