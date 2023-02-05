// import 'package:flutter/material.dart';
// import '../auth/postbaiviet.dart';
// import 'custom_icons.dart';
//
// void main() => runApp(const NewFeeds());
//
//
// class NewFeeds extends StatelessWidget {
//   const NewFeeds({Key? key}) : super(key: key);
//
//   static const String _title = 'StudentNet';
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//         title: _title,
//         home: Scaffold(
//           // appBar: AppBar(title: const Text(_title),),
//           //body: LoginBody(),
//           body: FeedBody(),
//         )
//     );
//   }
// }
//
// class FeedBody extends StatefulWidget {
//   const FeedBody({Key? key}) : super(key: key);
//
//   @override
//   State<FeedBody> createState() => _NewFeedsState();
// }
//
// class _NewFeedsState extends State<FeedBody> {
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Column(
//         children: [
//
//           Card(
//             elevation: 5.0,
//             margin: const EdgeInsets.all(8.0),
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             child: Stack(
//               //alignment: AlignmentDirectional.bottomEnd,
//               children: <Widget>[
//                 Container(
//                   child: const ClipOval(
//                     child: CircleAvatar(
//                       radius: 20,
//                       backgroundImage: NetworkImage(
//                           'https://scontent.fhan5-8.fna.fbcdn.net/v/t39.30808-6/321139157_1555501634935507_8854539622591512430_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=5R5HXLXVpAYAX9l-RZo&tn=aclcXteHYiC6yK0o&_nc_ht=scontent.fhan5-8.fna&oh=00_AfBzm0ePoWjy3lRI89msjWpHikeCgQu6Z0jOQUPfS6H_vg&oe=63DD469B'),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       // navigate to create feed screen
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => const PostBaiViet()));
//                     },
//                     child: Container(
//                       height: 36,
//                       margin: EdgeInsets.only(left: 20),
//                       padding: EdgeInsets.only(left: 40, right: 4),
//                       alignment: Alignment.centerLeft,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey, width: 1),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(25),
//                         ),
//                       ),
//                       child: Text(
//                         "Bạn đang nghĩ gì?",
//                         style: TextStyle(color: Colors.grey, fontSize: 16, height: 1.2),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 28,
//                   height: 28,
//                   margin: EdgeInsets.all(8),
//                   child: const Icon(
//                     Icons.image,
//                     color: Colors.green,
//                     size: 28,
//                   ),
//                 ),
//
//
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Communicate with friends',
//                     style: Theme.of(context)
//                         .textTheme
//                         .subtitle1
//                         ?.copyWith(color: Colors.white),
//                   ),
//                 ),
//             ],
//             ),
//           ),
//           ListView.separated(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: 3,
//             itemBuilder: (context, index) => buildPostItem(context),
//             separatorBuilder: (context, index) => const SizedBox(
//               height: 10.0,
//             ),
//           ),
//           const SizedBox(
//             height: 8.0,
//           ),
//         ],
//       ),
//     );
//   }
//
//
//
//   Widget buildPostItem(context) => Card(
//     elevation: 5.0,
//     margin: const EdgeInsets.symmetric(horizontal: 8.0),
//     clipBehavior: Clip.antiAliasWithSaveLayer,
//     child: Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               const CircleAvatar(
//                 radius: 25,
//                 backgroundImage: NetworkImage(
//                     'https://scontent.fhan5-8.fna.fbcdn.net/v/t39.30808-6/321139157_1555501634935507_8854539622591512430_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=5R5HXLXVpAYAX9l-RZo&tn=aclcXteHYiC6yK0o&_nc_ht=scontent.fhan5-8.fna&oh=00_AfBzm0ePoWjy3lRI89msjWpHikeCgQu6Z0jOQUPfS6H_vg&oe=63DD469B'),
//               ),
//               const SizedBox(
//                 width: 15.0,
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: const [
//                         Text(
//                           'Đinh Ngọc Huân',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             height: 1.4,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 7.0,
//                         ),
//                         Icon(
//                           Icons.check_circle,
//                           color: Colors.blue,
//                           size: 16.0,
//                         ),
//                       ],
//                     ),
//                     Text(
//                       '30/1/2023 10:20',
//                       style: Theme.of(context)
//                           .textTheme
//                           .caption
//                           ?.copyWith(height: 1.4),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 width: 15.0,
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.more_horiz,
//                   size: 18.0,
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Divider(
//               thickness: 1.0,
//               color: Colors.grey[300],
//             ),
//           ),
//           Text(
//             'Testttt new feed bài viết đăng tải bài viết abcccc',
//             style: Theme.of(context).textTheme.subtitle1,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 8.0,
//               bottom: 8.0,
//             ),
//             child: SizedBox(
//               width: double.infinity,
//               child: Wrap(
//                 children: [
//                   customHashText(
//                     text: '#Software',
//                     onPressed: () {},
//                   ),
//                   customHashText(
//                     text: '#Flutter',
//                     onPressed: () {},
//                   ),
//                   customHashText(
//                     text: '#IOS',
//                     onPressed: () {},
//                   ),
//                   customHashText(
//                     text: '#Android',
//                     onPressed: () {},
//                   ),
//                   customHashText(
//                     text: '#Web',
//                     onPressed: () {},
//                   ),
//                   customHashText(
//                     text: '#Development',
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             height: 160.0,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(4.0),
//               image: const DecorationImage(
//                 image: NetworkImage(
//                   'https://i.pinimg.com/564x/ae/65/07/ae65070db5a866992b80267f3da8dc05.jpg',
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: InkWell(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 5.0,
//                       ),
//                       child: Row(
//                         children: [
//                           const Icon(
//                             Icons.favorite_border,
//                             size: 17.0,
//                             color: Colors.red,
//                           ),
//                           const SizedBox(
//                             width: 5.0,
//                           ),
//                           Text(
//                             '120',
//                             style: Theme.of(context).textTheme.caption,
//                           ),
//                         ],
//                       ),
//                     ),
//                     onTap: () {},
//                   ),
//                 ),
//                 Expanded(
//                   child: InkWell(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 5.0,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           const Icon(
//                             CustomIcons.chat,
//                             size: 17.0,
//                             color: Colors.amber,
//                           ),
//                           const SizedBox(
//                             width: 5.0,
//                           ),
//                           Text(
//                             '520 bình luận',
//                             style: Theme.of(context).textTheme.caption,
//                           ),
//                         ],
//                       ),
//                     ),
//                     onTap: () {},
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               bottom: 8.0,
//             ),
//             child: Divider(
//               thickness: 1.0,
//               color: Colors.grey[300],
//             ),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: InkWell(
//                   child: Row(
//                     children: [
//                       const CircleAvatar(
//                         radius: 18,
//                         backgroundImage: NetworkImage(
//                             'https://img.freepik.com/free-photo/indecisive-girl-picks-from-two-choices-looks-questioned-troubled-crosses-hands-across-chest-hesitates-suggested-products-wears-yellow-t-shirt-isolated-crimson-wall_273609-42552.jpg?w=1380'),
//                       ),
//                       const SizedBox(
//                         width: 15.0,
//                       ),
//                       Text(
//                         'write a comment...',
//                         style: Theme.of(context).textTheme.caption,
//                       ),
//                     ],
//                   ),
//                   onTap: () {},
//                 ),
//               ),
//               InkWell(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 5.0,
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.favorite_border,
//                         size: 17.0,
//                         color: Colors.red,
//                       ),
//                       const SizedBox(
//                         width: 5.0,
//                       ),
//                       Text(
//                         'Like',
//                         style: Theme.of(context)
//                             .textTheme
//                             .caption
//                             ?.copyWith(fontSize: 13.5),
//                       ),
//                     ],
//                   ),
//                 ),
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
//
//   Widget customHashText({
//     required String text,
//     required VoidCallback onPressed,
//   }) {
//     return Padding(
//       padding: const EdgeInsetsDirectional.only(end: 6.0),
//       child: SizedBox(
//         height: 20.0,
//         child: MaterialButton(
//           onPressed: onPressed,
//           minWidth: 1.0,
//           padding: EdgeInsets.zero,
//           child: Text(
//             text,
//             style: const TextStyle(
//               color: Colors.blue,
//               fontSize: 14.0,
//             ),
//             //Theme.of(context).textTheme.caption?.copyWith(color: Colors.blue,),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
