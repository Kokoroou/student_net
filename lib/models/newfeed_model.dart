import 'dart:convert';
import 'package:http/http.dart';



class Postfeed {
  String? token;
  int? count;
  static List cleanPostList = [];
  Postfeed(this.token, this.count) {
    post_postList();
  }
  post_postList() async {
    // List cleanPostList = [];

    String url = 'http://184.169.213.180:3000/it4788/post/get_list_posts?token=' + token.toString() + '&last_id=0&index=0&count=' + count.toString();
    final uri = Uri.parse(url);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'token': token,
      'last_id': 0,
      'index': 0,
      'count': count
      };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');


    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    
    // return jsonDecode(responseBody.toString())['data']['posts'];
    for (var each in (jsonDecode(responseBody.toString())['data']['posts'])){
          if (each['image'] != null){
            cleanPostList.add(each);
          } 
      }

    print(cleanPostList);

  }

  List get PostList => cleanPostList;

  // Future<List> get response => post_postList(this.token, this.count);

}

void main()  {
  // List cleanPostList = [];
  Postfeed a = Postfeed('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzU2NGJjOTgxNTJmZjUzYjI2MDgxMyIsImRhdGVMb2dpbiI6IjIwMjMtMDEtMzFUMTc6MzU6NDUuMjQxWiIsImlhdCI6MTY3NTE4NjU0NSwiZXhwIjoxNjg1MTg2NTQ0fQ.U1LIKoaK7Szczs0cHFZ4STJ9nWqC4jZxO_ZwoEwFW-E', 50);
  print(a.PostList);
  Postfeed b = a;
  print(b.PostList);
  // for (var each in (await a.response)) {
  //   if (each['image'] != null) cleanPostList.add(each);
  // }
          

}