import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:student_net/search/search_bar.dart';

void main() => runApp(const HistorySearch());

class HistorySearch extends StatelessWidget {
  const HistorySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: History(),
    );
  }
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: [
          IconButton(
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Example()));
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
              child: Text('Lịch sử tìm kiếm',
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            ),
          ),
        ]),
        _HistorySearch(),
      ],
    )));
  }
}

class _HistorySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
          child: Text('Ngày 7 tháng 8 năm 2023',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        HistorySearchWidget(),
      ],
    ));
  }
}

// class HistorySearch extends StatelessWidget{
//   const HistorySearch({super.key});

//   @override
//   Widget build(BuildContext context){
//     return const MaterialApp(
//       title: "History Search",
//       home: Scaffold(
//         body: HistorySearchWidget(),
//       )
//     );
//   }
// }

class HistorySearchWidget extends StatelessWidget {
  const HistorySearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundImage:
                    AssetImage("assets/favicon.png"), // NOTE : ADD IMAGE
                radius: 35.0,
              ),
              SizedBox(width: 15.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("content",
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Text("time",
                      style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.delete),
                label: Text(
                  "",
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
