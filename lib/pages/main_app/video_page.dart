import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:student_net/models/newfeed_model.dart';
import 'package:student_net/pages/main_app/root_app.dart';
import 'package:student_net/pages/testData/post_json.dart';
import 'package:student_net/theme/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:student_net/pages/data/me_post_json.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  // Postfeed a = Postfeed('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzU2NGJjOTgxNTJmZjUzYjI2MDgxMyIsImRhdGVMb2dpbiI6IjIwMjMtMDEtMzFUMTc6MzU6NDUuMjQxWiIsImlhdCI6MTY3NTE4NjU0NSwiZXhwIjoxNjg1MTg2NTQ0fQ.U1LIKoaK7Szczs0cHFZ4STJ9nWqC4jZxO_ZwoEwFW-E', 50);

  late VideoPlayerController _controller_vp;

  @override
  void initState() {
    super.initState();
    _controller_vp = VideoPlayerController.network(meVideoList[0]['videoUrl']);

    _controller_vp.addListener(() {
      setState(() {});
    });
    _controller_vp.setLooping(true);
    _controller_vp.initialize().then((_) => setState(() {}));
    _controller_vp.play();
  }

  @override
  void dispose() {
    _controller_vp.dispose();
    super.dispose();
  }
  static Postfeed b = Postfeed(
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzU2NGJjOTgxNTJmZjUzYjI2MDgxMyIsImRhdGVMb2dpbiI6IjIwMjMtMDEtMzFUMTc6MzU6NDUuMjQxWiIsImlhdCI6MTY3NTE4NjU0NSwiZXhwIjoxNjg1MTg2NTQ0fQ.U1LIKoaK7Szczs0cHFZ4STJ9nWqC4jZxO_ZwoEwFW-E',
      50);

  List cleanPostList = b.PostList;


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
                return GestureDetector(
                  onTap: () {
                        playVideo(context, meVideoList[0]['videoUrl']);
                      },
              
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15),
                        width: double.infinity,
                        height: 300,
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
                                    cleanPostList[index]['image'][0]['url']),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(0)),
                      ),
                      Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                              color: white.withOpacity(0))),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(15),
                        height: 300,
                        decoration: BoxDecoration(),
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
                                        color: const Color(0xFFE5E5E5)
                                            .withOpacity(0.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Feather.heart,
                                          color: white,
                                          size: 17,
                                        ),
                                        Text(
                                          cleanPostList[index]['like'],
                                          style: const TextStyle(
                                              fontSize: 17, color: white),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 90,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFE5E5E5)
                                            .withOpacity(0.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          MaterialIcons.chat_bubble_outline,
                                          color: white,
                                          size: 17,
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
  
  playVideo(BuildContext context, videoUrl) {
    _controller_vp = VideoPlayerController.network(videoUrl);

    _controller_vp.addListener(() {
      setState(() {});
    });
    _controller_vp.setLooping(true);
    _controller_vp.initialize().then((_) => setState(() {}));
    _controller_vp.play();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: AspectRatio(
              aspectRatio: _controller_vp.value.aspectRatio,
              child: VideoPlayer(_controller_vp),
            )));
  }
}

