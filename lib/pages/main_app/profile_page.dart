import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:student_net/pages/friend/list_friend.dart';
import 'package:student_net/pages/settings/main_menu.dart';
import 'package:student_net/pages/data/me_post_json.dart';
import 'package:student_net/theme/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:student_net/models/info_user_model.dart';
import 'package:student_net/models/profile_post_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static Profile b =  Profile('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzU2NGJjOTgxNTJmZjUzYjI2MDgxMyIsImRhdGVMb2dpbiI6IjIwMjMtMDItMDRUMTU6MDE6MDkuNDM5WiIsImlhdCI6MTY3NTUyMjg2OSwiZXhwIjoxNjg1NTIyODY4fQ.-WUAe-idXMeAXzOAn879grosYBYz0c-pR9mt20cPlPc', '63c564bc98152ff53b260813');
  static ProfilePostList c = ProfilePostList('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzU2NGJjOTgxNTJmZjUzYjI2MDgxMyIsImRhdGVMb2dpbiI6IjIwMjMtMDEtMzFUMTc6MzU6NDUuMjQxWiIsImlhdCI6MTY3NTE4NjU0NSwiZXhwIjoxNjg1MTg2NTQ0fQ.U1LIKoaK7Szczs0cHFZ4STJ9nWqC4jZxO_ZwoEwFW-E', '63c564bc98152ff53b260813',50);
  Map<String, dynamic> profile = {};
  List profilePost = [];
  List profileVideo = [];
  createInfo() async {
    profile = await b.Info;
    profilePost = c.Profile_PostList_;
    profileVideo = c.Profile_VideoList_;
    print(profilePost);
    print(profileVideo);
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
    // try{
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
          child: getAppBar(), preferredSize: Size.fromHeight(180)),
      body: getBody(),
    );
    // }catch(e){return const Scaffold(
    //   backgroundColor: white
    // );}
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
                    (profilePost.length + profileVideo.length).toString(),
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
                    //Icons.ondemand_video_outlined,
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
                  children: List.generate(profilePost.length, (index) {
                    return Container(
                      width: (size.width - 60) / 2,
                      height: (size.width - 60) / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(
                                (profilePost[index]['image'] != null) ? profilePost[index]['image'][0]['url']: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSonLU-Pv6nhIjP3fIqsV97XAJwlCZqkZCyvg&usqp=CAU'),
                              fit: BoxFit.cover)),
                    );
                  }),
                )
              : Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: List.generate(profileVideo.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        playVideo_pf(context, profileVideo[index]['video']['url'], _controller_pf);
                      },
                      child: Container(
                        width: (size.width - 60) / 2,
                        height: (size.width - 60) / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage('data:image/jpeg;base64,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'),
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
