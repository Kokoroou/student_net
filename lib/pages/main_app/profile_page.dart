import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:student_net/pages/friend/list_friend.dart';
import 'package:student_net/pages/settings/main_menu.dart';
import 'package:student_net/pages/data/me_post_json.dart';
import 'package:student_net/theme/colors.dart';
import 'package:video_player/video_player.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isPhoto = true;
  bool nothing = false;

  late VideoPlayerController _controller;


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(meVideoList[0]['videoUrl']);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
          child: getAppBar(), preferredSize: Size.fromHeight(180)),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: primaryLight,
        flexibleSpace: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: black)),
                  child: Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/69932/tabby-cat-close-up-portrait-69932.jpeg?auto=compress&cs=tinysrgb&w=600"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Settings()));
                          },
                        ),
                      )),
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Nguyen Linh",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "@ljisoo1012",
              style: TextStyle(fontSize: 15),
            ),
          ],
        )));
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "Posts",
                    style: TextStyle(fontSize: 15, color: black),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "35",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Followers",
                    style: TextStyle(fontSize: 15, color: black),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "1,552",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Follow",
                    style: TextStyle(fontSize: 15, color: black),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "182",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isPhoto = true;
                      nothing = false;
                    });
                  },
                  icon: Icon(
                    Foundation.photo,
                    size: 25,
                    color: (isPhoto && !nothing ) ? primary : black,
                  )),
              IconButton(
                  onPressed: () {
                      isPhoto = false;
                      nothing = false;
                  },
                  icon: Icon(
                    Foundation.play_video,
                    size: 30,
                    color: (!isPhoto && !nothing )  ? primary : black,
                  )),
              IconButton(
                  onPressed: () {
                    nothing = true;
                    isPhoto = false;
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ListFriends()));
                  },
                  icon: Icon(
                    Foundation.address_book,
                    size: 30,
                    color: nothing ? primary : black,
                  ))
            ],
          ),
          SizedBox(
            height: 30,
          ),
          nothing
            ? Wrap():
          isPhoto
              ? Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: List.generate(mePostList.length, (index) {
                    return Container(
                      width: (size.width - 60) / 2,
                      height: (size.width - 60) / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(mePostList[index]),
                              fit: BoxFit.cover)),
                    );
                  }),
                )
              : Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: List.generate(meVideoList.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        playVideo(context, meVideoList[index]['videoUrl']);
                      },
                      child: Container(
                        width: (size.width - 60) / 2,
                        height: (size.width - 60) / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(meVideoList[index]['img']),
                                fit: BoxFit.cover)),
                        child: Center(
                          child: Icon(
                            AntDesign.playcircleo,
                            size: 40,
                            color: white,
                          ),
                        ),
                      ),
                    );
                  }),
                )
        ],
      ),
    );
  }

  playVideo(BuildContext context, videoUrl) {
    _controller = VideoPlayerController.network(videoUrl);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )));
  }
}
