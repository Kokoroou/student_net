import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'register.dart';


void main() => runApp(const LogIn());

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  static const String _title = 'StudentNet';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: _title,
        home: Scaffold(
          // appBar: AppBar(title: const Text(_title),),
          body: LoginBody(),
        )
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'StudentNet',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
          ),
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
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Số điện thoại',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Mật khẩu',
              ),
            ),
          ),
          Container(
            // height: 50,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: ElevatedButton(
              child: const Text('Đăng nhập'),
              onPressed: () {
                // print(nameController.text);
                // print(passwordController.text);

                // Work with API Login
                var loginController = _LogIn(nameController.text, passwordController.text);
                print(loginController.toString());
              },
            ),
          ),
          TextButton(
              onPressed: () {
                // Work with API Forgot Password
              },
              child: const Text('Quên mật khẩu?')
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // const Text('Does not have account?'),
              TextButton(
                  child: const Text(
                    'Tạo tài khoản mới',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: (){
                    _navigateToSignUp(context);
                  })
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToSignUp(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignUp()));
  }

  Future<http.Response> _LogIn(String phoneNumber, String password) {
    return http.post(
      Uri.parse('http://184.169.213.180:3000/it4788/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phonenumber': phoneNumber,
        'password': password,
      }),
    );
  }
}
