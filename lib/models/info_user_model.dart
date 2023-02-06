import 'dart:convert';
import 'package:http/http.dart';



class Profile {
  String? token;
  String? userid;

  late Future<Map<String, dynamic>> Info;

  Profile(this.token, this.userid) {
    Info = post_userinfo();
  }
  Future<Map<String, dynamic>> post_userinfo() async {
    Map<String, dynamic> Info = {};
    // List cleanPostList = [];

    String url = 'http://184.169.213.180:3000/it4788/user/get_user_info?token=' + token.toString() + '&user_id=' + userid.toString();
    //String url = 'http://184.169.213.180:3000/it4788/user/get_user_info?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzU2NGJjOTgxNTJmZjUzYjI2MDgxMyIsImRhdGVMb2dpbiI6IjIwMjMtMDItMDRUMTU6MDE6MDkuNDM5WiIsImlhdCI6MTY3NTUyMjg2OSwiZXhwIjoxNjg1NTIyODY4fQ.-WUAe-idXMeAXzOAn879grosYBYz0c-pR9mt20cPlPc&user_id=63c564bc98152ff53b260813';
    final uri = Uri.parse(url);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'token': token,
      'user_id': userid
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
    
    Info =  jsonDecode(responseBody.toString())['data'];
    return Info;

  }


  Future<Map<String, dynamic>> get Information => Info;

  // Future<List> get response => post_postList(this.token, this.count);

}

void main()async{
  // List cleanPostList = [];
  Profile a = Profile('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzU2NGJjOTgxNTJmZjUzYjI2MDgxMyIsImRhdGVMb2dpbiI6IjIwMjMtMDItMDRUMTU6MDE6MDkuNDM5WiIsImlhdCI6MTY3NTUyMjg2OSwiZXhwIjoxNjg1NTIyODY4fQ.-WUAe-idXMeAXzOAn879grosYBYz0c-pR9mt20cPlPc', '63c564bc98152ff53b260813');
  print(a.Info);

  // for (var each in (await a.response)) {
  //   if (each['image'] != null) cleanPostList.add(each);
  // }
          

}