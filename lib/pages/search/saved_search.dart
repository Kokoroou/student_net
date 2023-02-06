import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_net/models/search/del_search_model.dart';
import 'package:student_net/models/search/saved_search_model.dart';
import 'package:student_net/models/settings/user_model.dart';

import 'package:student_net/pages/search/search_bar.dart';
import 'package:student_net/services/api_service.dart';

void main() => runApp(const HistorySearch());

class HistorySearch extends StatelessWidget {
  const HistorySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recent"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
        ),
        body: Container(
            child: Stack(
          children: <Widget>[
            Column(children: <Widget>[
              History(),
            ]),
          ],
        )));
  }
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            MyListPage(),
          ],
        )
      ],
    );
  }
}

class MyListPage extends StatefulWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  List? data;
  List? ls_id_searches;

  @override
  Widget build(BuildContext context) {
    GetSavedSearchRequestModel model = GetSavedSearchRequestModel(
      token: UserModel.token,
      index: "0",
      count: "50",
    );
    if (data == null || data!.length == 0) {
      return FutureBuilder(
          future: APIService.get_ls_keywords(model),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              GetSavedSearchResponseModel response =
                  GetSavedSearchResponseModel.fromJson(
                      json.decode(snapshot.data.body));
              data = response.getKeywords()!;
              ls_id_searches = response.get_ls_id_searches()!;
              print("data");
              print(data);
              print(ls_id_searches);

              return ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: data!.length,
                itemBuilder: ((context, index) {
                  return Card(
                      color: Color.fromARGB(255, 201, 198, 198),
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(data![index]),
                            leading: Icon(Icons.search),
                            trailing: Container(
                              width: 20,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            data!.removeAt(index);
                                            DelSearchRequestModel model =
                                                new DelSearchRequestModel(
                                                    token: UserModel.token,
                                                    all: "0",
                                                    search_id:
                                                        ls_id_searches![index]);
                                            print("delete");
                                            APIService.del_saved_search(model)
                                                .then((value) {
                                            print(ls_id_searches![index]);
                                            ls_id_searches!.removeAt(index);

                                                  
                                            });
                                          });
                                        },
                                        icon: Icon(Icons.delete)),
                                  ),
                                ],
                              ),
                            ),
                          )));
                }),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    } else {
      return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: data!.length,
        itemBuilder: ((context, index) {
          return Card(
              color: Color.fromARGB(255, 201, 198, 198),
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(data![index]),
                    leading: Icon(Icons.search),
                    trailing: Container(
                      width: 20,
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    data!.removeAt(index);
                                    DelSearchRequestModel model =
                                        new DelSearchRequestModel(
                                            token: UserModel.token,
                                            all: "1",
                                            search_id: ls_id_searches![index]);
                                
                                    APIService.del_saved_search(model)
                                        .then((value) {
                              
                                    });
                                    ls_id_searches!.removeAt(index);
                                  });
                                },
                                icon: Icon(Icons.delete)),
                          ),
                        ],
                      ),
                    ),
                  )));
        }),
      );
    }
  }
}
