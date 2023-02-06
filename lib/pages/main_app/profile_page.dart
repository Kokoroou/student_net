import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:student_net/pages/friend/list_friend.dart';
import 'package:student_net/pages/settings/main_menu.dart';
import 'package:student_net/pages/data/me_post_json.dart';
import 'package:student_net/theme/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:student_net/models/info_user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static Profile b =  Profile('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzU2NGJjOTgxNTJmZjUzYjI2MDgxMyIsImRhdGVMb2dpbiI6IjIwMjMtMDItMDRUMTU6MDE6MDkuNDM5WiIsImlhdCI6MTY3NTUyMjg2OSwiZXhwIjoxNjg1NTIyODY4fQ.-WUAe-idXMeAXzOAn879grosYBYz0c-pR9mt20cPlPc', '63c564bc98152ff53b260813');

  Map<String, dynamic> profile = {};
  createInfo() async {
    profile = await b.Info;
  }

  _ProfilePageState(){
    createInfo();
  }

  bool isPhoto = true;
  bool nothing = false;

  static late VideoPlayerController _controller_pf;

  @override
  void initState() {
    super.initState();
    _controller_pf = VideoPlayerController.network(meVideoList[0]['videoUrl']);

    _controller_pf.addListener(() {
      setState(() {});
    });
    _controller_pf.setLooping(true);
    _controller_pf.initialize().then((_) => setState(() {}));
    _controller_pf.play();
  }

  @override
  void dispose() {
    _controller_pf.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try{
      try{
    print(profile);
      }catch(e){print('profile still null');}
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
          child: getAppBar(), preferredSize: Size.fromHeight(180)),
      body: getBody(),
    );
    }catch(e){return const Scaffold(
      backgroundColor: white
    );}
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
              (profile != {}) ? profile['username'] : 'null',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              (profile != {}) ? profile['description'] : 'please reload page',
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
                    mePostList.length.toString(),
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
                    (profile != {}) ? profile['listing'] : 'null',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
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
                    color: (!isPhoto && !nothing)  ? primary : black,
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
                        playVideo_pf(context, meVideoList[index]['videoUrl'], _controller_pf);
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

  playVideo_pf(BuildContext context, videoUrl, controller) {
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
