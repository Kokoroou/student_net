import 'dart:convert';
import 'package:http/http.dart';



class ProfilePostList {
  String? token;
  String? target_id;
  int? count;
  static List Profile_VideoList = [];
  static List Profile_PostList = [];
  ProfilePostList(this.token, this.target_id, this.count) {
    profile_postList();
  }
  profile_postList() async {
    // List cleanPostList = [];

    String url = 'http://184.169.213.180:3000/it4788/post/get_list_posts_in_profile?targetId='+ target_id.toString() + '&token=' + token.toString() + '&count=' + count.toString() + '&last_id=0&index=0';
    final uri = Uri.parse(url);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'target_id': target_id,
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
          if (each['video'] != null){
            Profile_VideoList.add(each);
          } else {
            Profile_PostList.add(each);
          }
      }
    
    print(Profile_PostList);
    print(Profile_PostList[1]['image'] != null);
    print(Profile_VideoList);

    // print(cleanPostList);

  }

  List get Profile_VideoList_ => Profile_VideoList;
  List get Profile_PostList_ => Profile_PostList;

  // Future<List> get response => post_postList(this.token, this.count);

}

void main()  async{
  // List cleanPostList = [];
  ProfilePostList a = ProfilePostList('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzU2NGJjOTgxNTJmZjUzYjI2MDgxMyIsImRhdGVMb2dpbiI6IjIwMjMtMDEtMzFUMTc6MzU6NDUuMjQxWiIsImlhdCI6MTY3NTE4NjU0NSwiZXhwIjoxNjg1MTg2NTQ0fQ.U1LIKoaK7Szczs0cHFZ4STJ9nWqC4jZxO_ZwoEwFW-E', '63c564bc98152ff53b260813',50);
  print(a.Profile_PostList_);
  print(a.Profile_VideoList_);
  // ProfilePostList b = a;
  // print(b.PostList);
  // for (var each in (await a.response)) {
  //   if (each['image'] != null) cleanPostList.add(each);
  // }
          

}