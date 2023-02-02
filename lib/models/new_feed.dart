// import 'dart:convert';
// import 'package:http/http.dart';

// // class Postfeed {
// //   String? code;
// //   String? message;
// //   Data? data;

// //   Postfeed({this.code, this.message, this.data});

// //   Postfeed.fromJson(Map<String, dynamic> json) {
// //     code = json['code'];
// //     message = json['message'];
// //     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['code'] = this.code;
// //     data['message'] = this.message;
// //     if (this.data != null) {
// //       data['data'] = this.data!.toJson();
// //     }
// //     return data;
// //   }
// // }

// // class Data {
// //   List<Posts>? posts;
// //   String? newItems;
// //   String? lastId;

// //   Data({this.posts, this.newItems, this.lastId});

// //   Data.fromJson(Map<String, dynamic> json) {
// //     if (json['posts'] != null) {
// //       posts = <Posts>[];
// //       json['posts'].forEach((v) {
// //         posts!.add(new Posts.fromJson(v));
// //       });
// //     }
// //     newItems = json['new_items'];
// //     lastId = json['last_id'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     if (this.posts != null) {
// //       data['posts'] = this.posts!.map((v) => v.toJson()).toList();
// //     }
// //     data['new_items'] = this.newItems;
// //     data['last_id'] = this.lastId;
// //     return data;
// //   }
// // }

// // class Posts {
// //   String? id;
// //   List<Image>? image;
// //   String? video;
// //   String? described;
// //   String? created;
// //   String? modified;
// //   String? like;
// //   String? comment;
// //   String? isLiked;
// //   String? isBlocked;
// //   String? canComment;
// //   String? canEdit;
// //   String? state;
// //   Author? author;

// //   Posts(
// //       {this.id,
// //       this.image,
// //       this.video,
// //       this.described,
// //       this.created,
// //       this.modified,
// //       this.like,
// //       this.comment,
// //       this.isLiked,
// //       this.isBlocked,
// //       this.canComment,
// //       this.canEdit,
// //       this.state,
// //       this.author});

// //   Posts.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     if (json['image'] != null) {
// //       image = <Image>[];
// //       json['image'].forEach((v) {
// //         image!.add(new Image.fromJson(v));
// //       });
// //     }
// //     video = json['video'];
// //     described = json['described'];
// //     created = json['created'];
// //     modified = json['modified'];
// //     like = json['like'];
// //     comment = json['comment'];
// //     isLiked = json['is_liked'];
// //     isBlocked = json['is_blocked'];
// //     canComment = json['can_comment'];
// //     canEdit = json['can_edit'];
// //     state = json['state'];
// //     author =
// //         json['author'] != null ? new Author.fromJson(json['author']) : null;
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     if (this.image != null) {
// //       data['image'] = this.image!.map((v) => v.toJson()).toList();
// //     }
// //     data['video'] = this.video;
// //     data['described'] = this.described;
// //     data['created'] = this.created;
// //     data['modified'] = this.modified;
// //     data['like'] = this.like;
// //     data['comment'] = this.comment;
// //     data['is_liked'] = this.isLiked;
// //     data['is_blocked'] = this.isBlocked;
// //     data['can_comment'] = this.canComment;
// //     data['can_edit'] = this.canEdit;
// //     data['state'] = this.state;
// //     if (this.author != null) {
// //       data['author'] = this.author!.toJson();
// //     }
// //     return data;
// //   }
// // }

// // class Image {
// //   String? id;
// //   String? url;

// //   Image({this.id, this.url});

// //   Image.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     url = json['url'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     data['url'] = this.url;
// //     return data;
// //   }
// // }

// // class Author {
// //   String? id;
// //   String? username;
// //   String? avatar;

// //   Author({this.id, this.username, this.avatar});

// //   Author.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     username = json['username'];
// //     avatar = json['avatar'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     data['username'] = this.username;
// //     data['avatar'] = this.avatar;
// //     return data;
// //   }
// // }



// Future<String>? post_postList(String? token, int? count) async {

//     String url = 'http://184.169.213.180:3000/it4788/post/get_list_posts?token=' + token.toString() + '&last_id=0&index=0&count=' + count.toString();
//     final uri = Uri.parse(url);
//     final headers = {'Content-Type': 'application/json'};
//     Map<String, dynamic> body = {
//       'token': token,
//       'last_id': 0,
//       'index': 0,
//       'count': count
//       };
//     String jsonBody = json.encode(body);
//     final encoding = Encoding.getByName('utf-8');


//     Response response = await post(
//       uri,
//       headers: headers,
//       body: jsonBody,
//       encoding: encoding,
//     );

//     int statusCode = response.statusCode;
//     String responseBody = response.body;

//     return responseBody;
//   }

// class Postfeed {
//   String? token;
//   int? count;
//   Future<String>? data;

//   Postfeed({this.token, this.count, this.data});


//   Future<String>? response = post_postList(token, count);


// }