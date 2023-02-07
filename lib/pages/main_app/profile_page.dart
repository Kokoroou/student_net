import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:student_net/models/post/list_post_model.dart';
import 'package:student_net/models/user/info_model.dart';
import 'package:student_net/pages/friend/list_friend.dart';
import 'package:student_net/pages/settings/main_menu.dart';
import 'package:student_net/pages/data/me_post_json.dart';
import 'package:student_net/services/api_service.dart';
import 'package:student_net/services/constants.dart';
import 'package:student_net/theme/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:student_net/models/info_user_model.dart';
import 'package:student_net/models/profile_post_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Profile? b;
  // ProfilePostList? c;
  Map? loginData;
  Map? profile;
  List? profilePost = [];
  List? profileVideo = [];

  bool isPhoto = true;
  bool nothing = false;

  static late VideoPlayerController _controller_pf;

  getInfo() async {
    // print("-------run:getInfo() in profile_page");
    await APIService.readCached("LoginRequestModel").then((response) {
      setState(() {
        // print("-----response:$response");
        loginData = response;
        // b = Profile(
        //   loginData!["token"],
        //   loginData!["id"],
        // );
        // c = ProfilePostList(loginData!["token"], loginData!["token"], 50);
      });
    });
    // print("----loginData: $loginData");

    GetInfoRequestModel model1 = GetInfoRequestModel(
        token: loginData!["token"], userId: loginData!["id"]);

    await APIService.getInfo(model1).then((response) {
      setState(() {
        profile = response["data"];
      });
    });

    ListInProfileRequestModel model2 = ListInProfileRequestModel(
        targetId: loginData!["id"],
        token: loginData!["token"],
        count: 20,
        lastId: 0,
        index: 0);

    await APIService.getListInProfile(model2).then((response) {
      setState(() {
        profilePost = response["data"]["posts"];
      });
    });

    ListVideosRequestModel model3 = ListVideosRequestModel(
        token: loginData!["token"], count: 20, lastId: 0, index: 0);

    await APIService.getListVideos(model3).then((response) {
      setState(() {
        profileVideo = response["data"]["posts"];
      });
    });

    // profile = await b!.Info;
    // profilePost = c!.Profile_PostList_;
    // profileVideo = c!.Profile_VideoList_;

    // print("----profilePost$profilePost");
    // print("----profileVideo$profileVideo");
  }

  _ProfilePageState() {
    getInfo();
  }

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
          preferredSize: const Size.fromHeight(180), child: getAppBar()),
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
                              image: NetworkImage((loginData!["avatar"] != null)
                                  ? loginData!["avatar"]
                                  : "https://images.pexels.com/photos/69932/tabby-cat-close-up-portrait-69932.jpeg?auto=compress&cs=tinysrgb&w=600"),
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
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Settings()));
                          },
                        ),
                      )),
                )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              (loginData!["username"] != null) ? loginData!["username"] : '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              (profile != {}) ? profile!['description'] : 'please reload page',
              style: const TextStyle(fontSize: 15),
            ),
          ],
        )));
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    "Posts",
                    style: TextStyle(fontSize: 15, color: black),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    (profilePost!.length + profileVideo!.length).toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "Followers",
                    style: TextStyle(fontSize: 15, color: black),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    (profile != {}) ? profile!['listing'] : 'null',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
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
                    color: (isPhoto && !nothing) ? primary : black,
                  )),
              IconButton(
                  onPressed: () {
                    isPhoto = false;
                    nothing = false;
                  },
                  icon: Icon(
                    Foundation.play_video,
                    size: 30,
                    color: (!isPhoto && !nothing) ? primary : black,
                  )),
              IconButton(
                  onPressed: () {
                    nothing = true;
                    isPhoto = false;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ListFriends()));
                  },
                  icon: Icon(
                    Foundation.address_book,
                    size: 30,
                    color: nothing ? primary : black,
                  ))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          nothing
              ? Wrap()
              : isPhoto
                  ? Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      children: List.generate(profilePost!.length, (index) {
                        return Container(
                          width: (size.width - 60) / 2,
                          height: (size.width - 60) / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: (profilePost![index]['image'] != null)
                                      ? NetworkImage(profilePost![index]
                                          ['image'][0]['url'])
                                      : Image.asset(
                                              'assets/images/default/image.png')
                                          .image,
                                  fit: BoxFit.cover)),
                        );
                      }),
                    )
                  : Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      children: List.generate(profileVideo!.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            playVideo_pf(
                                context,
                                profileVideo![index]['video']['url'],
                                _controller_pf);
                          },
                          child: Container(
                            width: (size.width - 60) / 2,
                            height: (size.width - 60) / 2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: Image.asset(
                                            'assets/images/default/video.png')
                                        .image,
                                    fit: BoxFit.cover)),
                            child: const Center(
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
