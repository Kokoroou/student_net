import 'package:flutter/material.dart';
import 'package:student_net/settings/main_menu.dart';
import 'package:student_net/settings/settings.dart';
import 'utils.dart';
import 'saved_search.dart';
import 'package:student_net/settings/block.dart';
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
                showSearch(context: context, delegate: Search());
              })
        ],
      ),
      drawer: const Drawer(),
    );
  }
}

class Search extends SearchDelegate {
  final int historyLength = 5;
  final cities = [
    "abcd",
    "edge",
    "acba",
    "adkamb",
    "mvalf",
    "avmalf",
    "kaieo",
    "mawf",
    "wekf",
    "mwlf",
    "awvm",
    "amwof",
    "pafwmf",
    "vmaww",
    "amwofj",
    "wmfow",
    "mmwcoam",
    "mcowfj",
    "mcownf",
    "owrqr"
  ];

  List<String> recentQuery = ["abcd", "edge", "acba"];
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

  @override
  Widget buildResults(BuildContext context) {
    //show some result based on selection
    // return IconButton(onPressed: (){}, icon: const Icon(Icons.search));
    if (query.isNotEmpty) {
      addFirst(query);
    }
    // return Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Container(
    //         width: double.infinity,
    //         decoration: BoxDecoration(
    //           color: Color(0xFF262626),
    //           borderRadius: BorderRadius.circular(12.0),
    //         ),
    //       ),
    //       feedBox("None", "Doctor code", "6 min", "I just wrote something", ""),
    //       feedBox("none", "Joseph Joestar", "6 min",
    //           "It's pretty good I like it", ""),
    //       feedBox("none", "Giorno giovana", "Yesterday",
    //           "I'm Giorno Giovana and I have a Dream", ""),
    //     ]);

    List<String> avatarUrl = [
      "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80",
      "https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80",
      "https://images.unsplash.com/photo-1525879000488-bff3b1c387cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    ];
    int hasResult = 0;
    if (hasResult == 1) {
      return Scaffold(
        //let's add the  bg color
        backgroundColor: Color.fromARGB(255, 153, 151, 151),

        //Now let's work on the body
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Now let's create the news feed
                //first we will make the custom container of the feed
                //Ok let's test our widget
                feedBox(avatarUrl[0], "Doctor code", "6 min",
                    "I just wrote something", "a"),
                feedBox(avatarUrl[0], "Doctor code", "6 min",
                    "I just wrote something", "a"),
                feedBox(avatarUrl[0], "Doctor code", "6 min",
                    "I just wrote something", "a"),
              ],
            ),
          ),
        ),
      );
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
                child: 
                Align(
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

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone searched for something
    var icon = Icon(Icons.history);
    if (query.isEmpty) {
      icon = Icon(Icons.history);
    } else
      icon = Icon(Icons.build);
    var suggestionList = recentQuery;
    if (query.isEmpty || query.length == 0) {
      suggestionList = recentQuery;
    } else {
      suggestionList = cities.where((p) => p.startsWith(query)).toList();
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
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Settings()));
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
                showResults(context);
                addFirst(query);
              },
              leading: icon,
              title: RichText(
                text: TextSpan(
                    text: suggestionList[index].substring(0, query.length),
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: suggestionList[index]..substring(query.length),
                          style: const TextStyle(color: Colors.grey))
                    ]),
              ),
            ),
          ],
        );
      },
      itemCount: suggestionList.length,
    );
  }
}
