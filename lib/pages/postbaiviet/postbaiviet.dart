import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:student_net/pages/auth/signup.dart';
// import 'package:flutter_quill/flutter_quill.dart';

void main() => runApp(const PostBaiViet());

class PostBaiViet extends StatelessWidget {
  const PostBaiViet({Key? key}) : super(key: key);

  static const String _title = 'StudentNet';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: _title,
        home: Scaffold(
          // appBar: AppBar(title: const Text(_title),),
          //body: LoginBody(),
          body: PostBody(),
        ));
  }
}

class PostBody extends StatefulWidget {
  const PostBody({Key? key}) : super(key: key);

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  TextEditingController nameController = TextEditingController();
  // QuillController _controller = QuillController.basic();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          // Container(
          //   alignment: Alignment.center,
          //   padding: const EdgeInsets.all(10),
          //   child: const Text(
          //     'Sign in',
          //     style: TextStyle(fontSize: 20),
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_back),
                    const SizedBox(
                      width: 20,
                    ),
                    Text('Create Post'),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      onPressed: () {},
                      child: Text('Post'),
                    )
                  ],
                ),
                Divider(
                  thickness: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/4/44/Facebook_Logo.png'),
                  title: Text("Huân đẹp trai"),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey),
                            onPressed: () {},
                            icon: Icon(Icons.group),
                            label: Row(
                              children: [
                                Text('Friends'),
                                Expanded(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey),
                            onPressed: () {},
                            icon: Icon(Icons.add),
                            label: Row(
                              children: [
                                Text('Album'),
                                Expanded(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What\'s on your Mind?',
                    hintStyle: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToSignUp(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpPage()));
  }

  Future<http.Response> _createPost(String phoneNumber, String password) {
    return http.post(
      Uri.parse('http://184.169.213.180:3000/it4788/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'post': phoneNumber,
        'password': password,
      }),
    );
  }
}
