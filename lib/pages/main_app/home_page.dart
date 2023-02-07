import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart';

import 'package:student_net/models/newfeed_model.dart';
import 'package:student_net/models/post/post_model.dart';
import 'package:student_net/pages/main_app/root_app.dart';
import 'package:student_net/pages/testData/post_json.dart';
import 'package:student_net/theme/colors.dart';
import 'package:video_player/video_player.dart';
import '../../theme/bottomsheet_widget.dart';
import 'comment_screen.dart';
import 'package:student_net/pages/data/me_post_json.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Postfeed a = Postfeed('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzU2NGJjOTgxNTJmZjUzYjI2MDgxMyIsImRhdGVMb2dpbiI6IjIwMjMtMDEtMzFUMTc6MzU6NDUuMjQxWiIsImlhdCI6MTY3NTE4NjU0NSwiZXhwIjoxNjg1MTg2NTQ0fQ.U1LIKoaK7Szczs0cHFZ4STJ9nWqC4jZxO_ZwoEwFW-E', 50);
  static List cleanPostList = [];
  static late VideoPlayerController _controller_vp2;
  static const token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzU2NGJjOTgxNTJmZjUzYjI2MDgxMyIsImRhdGVMb2dpbiI6IjIwMjMtMDEtMzFUMTc6MzU6NDUuMjQxWiIsImlhdCI6MTY3NTE4NjU0NSwiZXhwIjoxNjg1MTg2NTQ0fQ.U1LIKoaK7Szczs0cHFZ4STJ9nWqC4jZxO_ZwoEwFW-E';
  Postfeed a = Postfeed(token, 50);

  likePost(id, token, index) async {
    print("tesst like");
    String url = 'http://184.169.213.180:3000/it4788/like/like?token=' +
        token.toString() +
        '&id=' +
        id.toString();
    final uri = Uri.parse(url);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'token': token,
      'id': id.toString(),
    };


  @override
  void initState() {
    super.initState();
    _controller_vp2 = VideoPlayerController.network(meVideoList[0]['videoUrl']);

    // _controller_vp2.addListener(() {
    //   setState(() {});
    // });
    _controller_vp2.setLooping(true);
    _controller_vp2.initialize().then((_) => setState(() {}));
    _controller_vp2.play();
  }

  @override
  void dispose() {
    _controller_vp2.dispose();
    super.dispose();
  }

    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    var response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    cleanPostList[index]['like'] =
        jsonDecode(response.body.toString())['data']['like'];
    print(cleanPostList[index]['like']);
    setState(() {
      cleanPostList = List.from(cleanPostList);
    });
  }

  cleanData() async {
    cleanPostList = await a.PostList;
  }

  _HomePageState() {
    cleanData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60), child: getAppBar()),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: white,
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Student Net",
              style: TextStyle(
                  fontSize: 18, color: black, fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Feather.bell,
                  color: black,
                  size: 25,
                ))
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "News Feed",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: List.generate(cleanPostList.length, (index) {
                //Map<String, dynamic> map = jsonDecode(cleanPostList[index]);
                PostModel post = PostModel.fromJson(cleanPostList[index]);
                //PostModel post = cleanPostList[index];
                return GestureDetector(
                  
                  onTap: () {
                      cleanPostList[index]['video'] != null ?  playVideo_vp2(context, cleanPostList[index]['video']['url'], _controller_vp2) : print('no video');
                      },

                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 288,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: grey.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 15,
                                  offset: const Offset(0, 1))
                            ],
                            image: DecorationImage(
                                image: NetworkImage(
                                  (cleanPostList[index]['image'] != null) ?  cleanPostList[index]['image'][0]['url'] : ((cleanPostList[index]['video'] == null) ? 'data:image/png;base64,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' : 'data:image/jpeg;base64,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')),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                          width: double.infinity,
                          height: 288,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: black.withOpacity(0.25))),
                      Container(
                        width: double.infinity,
                        height: 288,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage((cleanPostList[
                                                        index]['author']
                                                    ['avatar'] ==
                                                null)
                                            ? "https://images.pexels.com/photos/20787/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=600"
                                            : 'https://firebasestorage.googleapis.com/v0/b/facebook-24888.appspot.com/o/2023-02-02T15:33:51.384ZFB_IMG_1675211211916.jpg?alt=media'),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (cleanPostList[index]['author']
                                                        ['username'] ==
                                                    null)
                                                ? 'người dùng'
                                                : cleanPostList[index]['author']
                                                    ['username'],
                                            style: const TextStyle(
                                                fontSize: 15, color: white),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            '1 hour ago',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: white.withOpacity(0.8)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Icon(
                                    Entypo.dots_three_vertical,
                                    color: white,
                                    size: 20,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 90,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(27),
                                        color: const Color(0xFFE5E5E5)
                                            .withOpacity(0.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          icon: cleanPostList[index]
                                                      ['is_liked'] ==
                                                  "1"
                                              ? const Icon(
                                                  Icons.thumb_up,
                                                  color: Colors.red,
                                                  size: 24.0,
                                                )
                                              : const Icon(
                                                  Icons.thumb_up,
                                                  color: white,
                                                  size: 24.0,
                                                ),
                                          onPressed: () {
                                            likePost(cleanPostList[index]['id'],
                                                token, index);
                                          },
                                        ),
                                        Text(
                                          cleanPostList[index]['like'],
                                          style: const TextStyle(
                                              fontSize: 17, color: white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 90,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(27),
                                        color: const Color(0xFFE5E5E5)
                                            .withOpacity(0.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            MaterialIcons.chat_bubble_outline,
                                            color: white,
                                            size: 24.0,
                                          ),
                                          onPressed: () {
                                            showModalFullSheet(
                                              context,
                                              [
                                                WillPopScope(
                                                  onWillPop: () async {
                                                    //postBloc.add(GetPostByIdEvent(id: post.id!));
                                                    return true;
                                                  },
                                                  child:
                                                      CommentScreen(post: post),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        Text(
                                          cleanPostList[index]['comment'],
                                          style: const TextStyle(
                                              fontSize: 17, color: white),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
  playVideo_vp2(BuildContext context, videoUrl, controller) {
    controller = VideoPlayerController.network(videoUrl);

    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize().then((_) => setState(() {}));
    controller.play();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            )));
  }
}