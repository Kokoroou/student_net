import 'dart:convert';
import 'package:http/http.dart';



class SearchPostfeed {
  String? token;
  int? count;
  String? keyword;
  static List cleanPostList = [];
  SearchPostfeed(this.token, this.count, this.keyword) {
  }
  Future post_postList() async {
    // List cleanPostList = [];

    String url = 'http://184.169.213.180:3000/it4788/search/search?token=' + token.toString() +  '&index=0&count=' + count.toString() + '&keyword=' + keyword.toString() ;
    print(url);
    // return [];
    final uri = Uri.parse(url);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'token': token,
      'index': 0,
      'count': count,
      'keyword': keyword
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
    
    print(cleanPostList.length);
    // print(cleanPostList);

    return cleanPostList;

  }

  List get PostList => cleanPostList;

  // Future<List> get response => post_postList(this.token, this.count);

}