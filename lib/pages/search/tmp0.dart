// import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';
// import 'package:student_net/pages/search/search_bar.dart';

// void main() => runApp(const HistorySearch());

// class HistorySearch extends StatelessWidget {
//   const HistorySearch({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Recent"),
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.grey,
//         ),
//         body: Container(
//             child: Stack(
//           children: <Widget>[
//             Column(children: <Widget>[
//               Container(
//                 height: 20,
//                 color: Colors.blue,
//               ),
//               MyListPage(),
//               MyListPage(),
//             ]),
//           ],
//         )));
//   }
// }

// class History extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: <Widget>[
//         Container(
//           height: 40,
//           color: Colors.deepOrange,
//           child: Center(
//             child: Text(
//               'Ngày 7 tháng 8 năm 2020',
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ),
//         ),
//         MyListPage(),
//         Container(
//           height: 40,
//           color: Colors.deepOrange,
//           child: Center(
//             child: Text(
//               'Footer',
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class MyListPage extends StatefulWidget {
//   const MyListPage({Key? key}) : super(key: key);

//   @override
//   State<MyListPage> createState() => _MyListPageState();
// }

// class _MyListPageState extends State<MyListPage> {
//   List<String> data = ["1", "2", "3", "4"];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       physics: ScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: data.length,
//       itemBuilder: ((context, index) {
//         return Card(
//             color: Colors.orange,
//             child: Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: ListTile(
//                   title: Text(data[index]),
//                   trailing: Container(
//                     width: 20,
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   data.removeAt(index);
//                                 });
//                               },
//                               icon: Icon(Icons.delete)),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )));
//       }),
//     );
//   }
// }
