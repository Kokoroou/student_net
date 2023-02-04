import 'dart:convert';
import 'package:http/http.dart';

Future<void> main()  async {
  String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzU2NGJjOTgxNTJmZjUzYjI2MDgxMyIsImRhdGVMb2dpbiI6IjIwMjMtMDEtMzFUMTc6MzU6NDUuMjQxWiIsImlhdCI6MTY3NTE4NjU0NSwiZXhwIjoxNjg1MTg2NTQ0fQ.U1LIKoaK7Szczs0cHFZ4STJ9nWqC4jZxO_ZwoEwFW-E';
  int count = 20;
  List cleanPostList = [];

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


    final response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    ).then((response) {
      if (response.statusCode == 200) {
        print("Response received.");
      }
      else {
        print("Response not received");
      }
    });

    print(response);

}