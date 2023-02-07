import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:student_net/config.dart';
import 'dart:convert';
import 'package:student_net/pages/auth/signup.dart';
import 'package:student_net/services/api_service.dart';
// import 'package:flutter_quill/flutter_quill.dart';

// void main() => runApp(const PostBaiViet());

// class PostBaiViet extends StatelessWidget {
//   const PostBaiViet({Key? key}) : super(key: key);

//   static const String _title = 'StudentNet';

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//         title: _title,
//         home: Scaffold(
//           // appBar: AppBar(title: const Text(_title),),
//           //body: LoginBody(),
//           body: PostBaiViet(),
//         ));
//   }
// }

class PostBaiViet extends StatefulWidget {
  const PostBaiViet({Key? key}) : super(key: key);

  @override
  State<PostBaiViet> createState() => _PostBaiVietState();
}

class _PostBaiVietState extends State<PostBaiViet> {
  TextEditingController nameController = TextEditingController();
  // QuillController _controller = QuillController.basic();
  TextEditingController passwordController = TextEditingController();
  Map? loginData = {};

  getInfo() async {
    await APIService.readCached("LoginRequestModel").then((response) {
      setState(() {
        loginData = response;
      });
    });
  }

  _PostBaiVietState() {
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Tạo bài viết',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      onPressed: () {},
                      child: const Text('Đăng'),
                    )
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: (loginData!["avatar"] != null)
                      ? Image.network(loginData!["avatar"])
                      : Image.asset('assets/images/default/avatar.png'),
                  title: Text((loginData!["username"] != null)
                      ? loginData!["username"]
                      : "Username"),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey),
                            onPressed: () {
                              FormHelper.showSimpleAlertDialog(
                                  context,
                                  Config.appName,
                                  "Hiện tại chỉ có thể đăng bài công khai!",
                                  "OK", () {
                                Navigator.pop(context);
                              });
                            },
                            icon: const Icon(Icons.group),
                            label: Row(
                              children: [
                                const Text('Public'),
                                const Expanded(
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
                            onPressed: () {
                              FormHelper.showSimpleAlertDialog(
                                  context,
                                  Config.appName,
                                  "Hiện chưa hỗ trợ tính năng này!",
                                  "OK", () {
                                Navigator.pop(context);
                              });
                            },
                            icon: const Icon(Icons.add),
                            label: Row(
                              children: [
                                const Text('Cảm xúc'),
                                const Expanded(
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
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Bạn đang nghĩ gì?',
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
