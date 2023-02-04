// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:student_net/pages/search/search_bar.dart';

// void main() => runApp(const BlockPage());

// class BlockPage extends StatelessWidget {
//   const BlockPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Danh sách chặn"),
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.grey,
//         ),
//         body: Container(
//             child: Stack(
//           children: <Widget>[
//             Column(children: <Widget>[
//               History(),
//               // History(),
//             ]),
//           ],
//         )));
//   }
// }

// class History extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Column(
//           children: <Widget>[
//             Container(
//               height: 40,
//               color: Colors.white,
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Người bị chặn',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               // height: 40,
//               color: Colors.white,
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Một khi bạn đã chặn ai đó, họ sẽ không xem được nội dung bạn tự đăng trên dòng thời gian mình, gắn thẻ bạn, mời bạn tham gia sự kiện hoặc nhóm, bắt đầu cuộc trò chuyện với bạn hay thêm bạn làm bạn bè. Điều này không bao gồm các ứng dụng, trò chơi hay nhóm mà cả bạn và người này đều tham gia.',
//                     style: TextStyle(color: Colors.grey, fontSize: 14),
//                   ),
//                 ),
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   // padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 40,
//                     child: TextButton(
//                       style: TextButton.styleFrom(
//                         primary: Colors.blue,
//                       ),
//                       onPressed: () {},
//                       child: Text('THÊM VÀO DANH SÁCH CHẶN'),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             MyListPage(),
//           ],
//         )
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
//   get_list_blocks() async {
//     var response = await http.post(
//       Uri.parse(
//         "http://184.169.213.180:3000/it4788/friend/get_list_blocks/",
//       ),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'token':
//             "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzNiZDUyOTgxNTJmZjUzYjI2MDgwNSIsImRhdGVMb2dpbiI6IjIwMjMtMDItMDFUMTI6NTc6MTYuODM3WiIsImlhdCI6MTY3NTI1NjIzNywiZXhwIjoxNjg1MjU2MjM2fQ.AafjbzuumSE915Om3JoD1qLuyhJbtVJDD1A9aLVHpBc",
//         "index": "0",
//         "count": "5",
//       }),
//     );
//     print(response.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     get_list_blocks();
//     return ListView.builder(
//       physics: ScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: data.length,
//       itemBuilder: ((context, index) {
//         return Card(
//             color: Color.fromARGB(255, 230, 227, 227),
//             child: Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: ListTile(
//                   title: Text(data[index]),
//                   leading: CircleAvatar(
//                     radius: 30,
//                     child: CircleAvatar(
//                       backgroundImage: AssetImage("assets/favicon.png"),
//                       // backgroundImage: NetworkImage(avatarUrl),
//                       radius: 25.0,
//                       // backgroundColor: Colors.black,
//                     ),
//                     // backgroundColor: Colors.white,
//                   ),
//                   trailing: Container(
//                     width: 80,
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: TextButton(
//                             style: TextButton.styleFrom(
//                               textStyle: const TextStyle(fontSize: 14),
//                             ),
//                             onPressed: () {},
//                             child: const Text(
//                               'Bỏ chặn',
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )));
//       }),
//     );
//   }
// }
