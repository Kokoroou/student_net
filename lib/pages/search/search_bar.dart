import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:student_net/models/newfeed_model.dart';
import 'package:student_net/models/search/saved_search_model.dart';
import 'package:student_net/pages/friend/list_friend.dart';
import 'package:student_net/pages/search/result_search.dart';
import 'package:student_net/pages/settings/main_menu.dart';
import 'package:student_net/pages/settings/settings.dart';
import 'package:student_net/services/api_service.dart';
import 'package:student_net/theme/colors.dart';
import 'utils.dart';
import 'saved_search.dart';
import 'package:student_net/pages/settings/block.dart';
/* 
This file only contain the search bar 
*/

void main() => runApp(const Example());

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "Search Bar",
        home: Scaffold(
          body: ExampleBody(),
        ));
  }
}

class ExampleBody extends StatelessWidget {
  const ExampleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search App"),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: Search(saved_search: take_recentSearch()));
              })
        ],
      ),
      drawer: const Drawer(),
    );
  }
}

List? take_recentSearch() {
  GetSavedSearchRequestModel model = GetSavedSearchRequestModel(
    token:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzNiZDUyOTgxNTJmZjUzYjI2MDgwNSIsImRhdGVMb2dpbiI6IjIwMjMtMDItMDVUMTM6MzM6MTMuNjE0WiIsImlhdCI6MTY3NTYwMzk5MywiZXhwIjoxNjg1NjAzOTkyfQ.CZgztk66_euGrhBTC5RjLgtvN6eJDxoZ56bpBByrPkM",
    index: "0",
    count: "20",
  );

  APIService.get_ls_keywords(model).then((value) {
    // print(value.body);
    GetSavedSearchResponseModel response =
        GetSavedSearchResponseModel.fromJson(json.decode(value.body));

    // if (recentQuery.isEmpty){
    print(response.getKeywords());
    print("helllo");
    return response.getKeywords();
  });
}

class Search extends SearchDelegate {
  final int historyLength = 5;
  List<dynamic> ls_keywords = [];
  List<dynamic> recentQuery = [];
  List? saved_search;
  Search({this.saved_search}) : super();

  void removeQuery(String term) {
    if (recentQuery.contains(term)) {
      recentQuery.remove(term);
    }
  }

  void addFirst(String term) {
    if (recentQuery.contains(term)) {
      removeQuery(term);
    }
    recentQuery.insert(0, term);
    if (recentQuery.length > historyLength) {
      recentQuery = recentQuery.sublist(0, historyLength);
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // actions for app Bar
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  static List cleanPostList = [];

  @override
  Widget? buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  Widget body() {
    return Scaffold(
        //let's add the  bg color
        backgroundColor: Color.fromARGB(255, 153, 151, 151),

        //Now let's work on the body
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
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
                                    image: NetworkImage(cleanPostList[index]
                                        ['image'][0]['url']),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                (cleanPostList[index]['author']
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
                                                    : cleanPostList[index]
                                                        ['author']['username'],
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
                                                    color:
                                                        white.withOpacity(0.8)),
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
                                            borderRadius:
                                                BorderRadius.circular(27),
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
                                            borderRadius:
                                                BorderRadius.circular(27),
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
        ));
  }

  StreamController controller = new StreamController();
  @override
  Widget buildResults(BuildContext context) {
    //show some result based on selection
    // return IconButton(onPressed: (){}, icon: const Icon(Icons.search));
    if (query.isNotEmpty) {
      addFirst(query);
    } else {
      return const Center(
          child: Text(
        "Từ khóa tìm kiếm rỗng.",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ));
    }

    int hasResult = 1;
    if (hasResult == 1) {
      SearchPostfeed a = SearchPostfeed(
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzNiZDUyOTgxNTJmZjUzYjI2MDgwNSIsImRhdGVMb2dpbiI6IjIwMjMtMDItMDVUMTU6MDE6MTYuNTEwWiIsImlhdCI6MTY3NTYwOTI3NiwiZXhwIjoxNjg1NjA5Mjc1fQ.2W1PVqZt4ZHwpkW5uYNdIxNkBKhnDFmVy73CE6e4Rik',
          50,
          query);
      // cleanData(a);
      return FutureBuilder(
          future: a.post_postList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return const Center(
                    child: Text(
                  "Không tìm thấy bài viết.",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ));
              }
              cleanPostList = snapshot.data;

              return body();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    } else {
      return Scaffold(
          backgroundColor: Colors.grey,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    child: Column(
                      children: [
                        Icon(Icons.cloud_off),
                        Text('Không có kết nối mạng',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {},
                      child: Text('Thử lại'),
                    )),
              ),
            ],
          ));
    }
  }

  void update(List<dynamic> recent, List<dynamic> keywords) {
    recentQuery = recent;
    ls_keywords = keywords;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone searched for something

    // print(recentQuery);

    var icon = Icon(Icons.history);
    if (query.isEmpty) {
      icon = Icon(Icons.history);
    } else
      icon = Icon(Icons.build);
    List suggestionList = recentQuery;
    if (query.isEmpty || query.length == 0) {
      suggestionList = recentQuery;
    } else {
      suggestionList = ls_keywords.where((p) => p.startsWith(query)).toList();
    }

    GetSavedSearchRequestModel model = GetSavedSearchRequestModel(
      token:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzNiZDUyOTgxNTJmZjUzYjI2MDgwNSIsImRhdGVMb2dpbiI6IjIwMjMtMDItMDVUMTU6MDE6MTYuNTEwWiIsImlhdCI6MTY3NTYwOTI3NiwiZXhwIjoxNjg1NjA5Mjc1fQ.2W1PVqZt4ZHwpkW5uYNdIxNkBKhnDFmVy73CE6e4Rik",
      index: "0",
      count: "20",
    );
    // if (recentQuery.length == 0) {
    //   APIService.get_ls_keywords(model).then((value) {
    //     // print(value.body);
    //     GetSavedSearchResponseModel response =
    //         GetSavedSearchResponseModel.fromJson(json.decode(value.body));
    //     this.recentQuery = response.getKeywords()!;
    //     this.ls_keywords = response.getKeywords()!;
    //   });
    // }
    // print("query lenght");

    return FutureBuilder(
        future: APIService.get_ls_keywords(model),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            GetSavedSearchResponseModel response =
                GetSavedSearchResponseModel.fromJson(
                    json.decode(snapshot.data.body));
            print("ahiahihi");
            recentQuery = response.getKeywords()!;
            print(recentQuery);
            ls_keywords = response.getKeywords()!;
            var icon = Icon(Icons.history);
            if (query.isEmpty) {
              icon = Icon(Icons.history);
            } else
              icon = Icon(Icons.build);
            List suggestionList = recentQuery;
            if (query.isEmpty || query.length == 0) {
              suggestionList = recentQuery;
            } else {
              suggestionList =
                  ls_keywords.where((p) => p.startsWith(query)).toList();
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                        height: index > 0 ? 0 : 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: const Text('Tìm kiếm gần đây',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)))),
                            // Expanded(
                            //   child: Padding(
                            //       padding: const EdgeInsets.all(10),
                            //       child: Text('Lịch sử tìm kiếm',
                            //           textAlign: TextAlign.right,
                            //           style: TextStyle(
                            //               fontWeight: FontWeight.bold,
                            //               fontSize: 14,
                            //               color: Colors.grey))),
                            // ),
                            Container(
                                child: InkWell(
                              onTap: () {
                                print('hiện thị lịch sử tìm kiếm ');
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ListFriends()));
                              },
                              child: const Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('Lịch sử tìm kiếm',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.grey))),
                            )),
                          ],
                        )),
                    ListTile(
                      onTap: () {
                        if (query.isEmpty) {
                          query = suggestionList[index].toString();
                        }
                        showResults(context);
                        addFirst(query);
                      },
                      leading: icon,
                      title: RichText(
                        text: TextSpan(
                            text: suggestionList[index]
                                .substring(0, query.length),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: suggestionList[index]
                                      .substring(query.length),
                                  style: const TextStyle(color: Colors.grey))
                            ]),
                      ),
                    ),
                  ],
                );
              },
              itemCount: suggestionList.length,
            );
          } else {
            buildSuggestions(context);
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
