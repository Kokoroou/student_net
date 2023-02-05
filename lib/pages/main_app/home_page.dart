import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart';

import 'package:student_net/models/newfeed_model.dart';
import 'package:student_net/pages/main_app/root_app.dart';
import 'package:student_net/pages/testData/post_json.dart';
import 'package:student_net/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Postfeed a = Postfeed('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzU2NGJjOTgxNTJmZjUzYjI2MDgxMyIsImRhdGVMb2dpbiI6IjIwMjMtMDEtMzFUMTc6MzU6NDUuMjQxWiIsImlhdCI6MTY3NTE4NjU0NSwiZXhwIjoxNjg1MTg2NTQ0fQ.U1LIKoaK7Szczs0cHFZ4STJ9nWqC4jZxO_ZwoEwFW-E', 50);

  static List cleanPostList = [];
  static const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzU2NGJjOTgxNTJmZjUzYjI2MDgxMyIsImRhdGVMb2dpbiI6IjIwMjMtMDEtMzFUMTc6MzU6NDUuMjQxWiIsImlhdCI6MTY3NTE4NjU0NSwiZXhwIjoxNjg1MTg2NTQ0fQ.U1LIKoaK7Szczs0cHFZ4STJ9nWqC4jZxO_ZwoEwFW-E';
  Postfeed a = Postfeed(
  token,
      50);


  likePost(id, token) async {
    print("tesst like");
    String url = 'http://184.169.213.180:3000/it4788/like/like?token=' + token.toString() + '&id=' + id.toString();
    final uri = Uri.parse(url);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'token': token,
      'id': id.toString(),
    };

    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );


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
                return Padding(
                  padding: const EdgeInsets.only(bottom: 25),
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
                                    cleanPostList[index]['image'][0]['url']),
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
                                           icon: const Icon(
                                             Feather.heart,
                                             color: white,
                                             size: 17,),
                                           onPressed: () {
                                             likePost(cleanPostList[index]['id'],token);

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
}
