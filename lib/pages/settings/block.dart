import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_net/models/settings/block_model.dart';
import 'package:student_net/models/settings/set_block.model.dart';
import 'package:student_net/models/settings/user_model.dart';
import 'package:student_net/pages/search/search_bar.dart';
import 'package:student_net/pages/search/utils.dart';
import 'package:student_net/services/api_service.dart';

void main() => runApp(const BlockPage());

class BlockPage extends StatelessWidget {
  const BlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Danh sách chặn"),
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
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Người bị chặn',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              // height: 40,
              color: Colors.white,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Một khi bạn đã chặn ai đó, họ sẽ không xem được nội dung bạn tự đăng trên dòng thời gian mình, gắn thẻ bạn, mời bạn tham gia sự kiện hoặc nhóm, bắt đầu cuộc trò chuyện với bạn hay thêm bạn làm bạn bè. Điều này không bao gồm các ứng dụng, trò chơi hay nhóm mà cả bạn và người này đều tham gia.',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  // padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      onPressed: () {},
                      child: Text('THÊM VÀO DANH SÁCH CHẶN'),
                    ),
                  ),
                )
              ],
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
  List? data = [];
  BlockRequestModel model = new BlockRequestModel(
    token: UserModel.token,
    index: "0",
    count: "50",
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: APIService.get_ls_blocks(model),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            BlockResponseModel response =
                BlockResponseModel.fromJson(json.decode(snapshot.data.body));

            data = response.getListBlocks();

            return ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: data!.length,
              itemBuilder: ((context, index) {
                return Card(
                    color: Color.fromARGB(255, 230, 227, 227),
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(data![index].username),
                          leading: CircleAvatar(
                            radius: 30,
                            child: CircleAvatar(
                              backgroundImage: getAvatar(data![index].avatar),
                              // backgroundImage: NetworkImage(avatarUrl),
                              radius: 25.0,
                              // backgroundColor: Colors.black,
                            ),
                            // backgroundColor: Colors.white,
                          ),
                          trailing: Container(
                            width: 80,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: const TextStyle(fontSize: 14),
                                    ),
                                    onPressed: () {
                                      
                                      SetBlockRequestModel model =
                                          SetBlockRequestModel(
                                              token: UserModel.token,
                                              user_id: data![index].id,
                                              type: "1");

                                      APIService.set_block(model).then((value) {
                                        print(value);
                                        if (value == 200) {
                                          data!.removeAt(index);
                                          showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title:
                                                        const Text('Thông báo'),
                                                    content: const Text(
                                                        'Đã bõ chặn thành công'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, 'OK');
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ));
                                        }
                                      });
                                    },
                                    child: const Text(
                                      'Bỏ chặn',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
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
}
