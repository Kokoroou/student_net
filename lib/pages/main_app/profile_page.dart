import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:student_net/testData/me_post_json.dart';
import 'package:student_net/theme/colors.dart';
import 'package:video_player/video_player.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isPhoto = true;

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
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
                    });
                  },
                  icon: Icon(
                    Foundation.photo,
                    size: 25,
                    color: black,
                  )),
              IconButton(
                  onPressed: () {
                  },
                  icon: Icon(
                    Foundation.address_book,
                    size: 30,
                    color: black,
                  ))
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Wrap(
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
              
        ],
      ),
    );
  }


}
