import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:student_net/config.dart';
import 'package:student_net/models/auth/login_model.dart';
import 'package:student_net/services/api_service.dart';

import 'register.dart';

// void main() => runApp(const LoginPage());
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? phonenumber;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(Config.hexColor5),
        body: ProgressHUD(
          inAsyncCall: isAPICallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: _loginUI(context),
          ),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            HexColor(Config.hexColor2),
            HexColor(Config.hexColor4),
            HexColor(Config.hexColor3),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5.2,
              // decoration: const BoxDecoration(
              //   gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [
              //       Colors.black,
              //       Colors.black,
              //     ],
              //   ),
              //   borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(100),
              //     bottomRight: Radius.circular(100),
              //   ),
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/Logo.png",
                      width: 250,
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      bottom: 30,
                      top: 50,
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  FormHelper.inputFieldWidget(
                    context,
                    "phonenumber",
                    "Số điện thoại",
                    (onValidateVal) {
                      if (onValidateVal.isEmpty) {
                        return "Số điện thoại không được để trống.";
                      }
                    },
                    (onSavedVal) {
                      phonenumber = onSavedVal;
                    },
                    borderFocusColor: Colors.black,
                    prefixIconColor: Colors.black,
                    borderColor: Colors.black,
                    textColor: Colors.black,
                    hintColor: Colors.black.withOpacity(0.7),
                    borderRadius: 10,
                    showPrefixIcon: true,
                    prefixIcon: Icon(Icons.phone),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: FormHelper.inputFieldWidget(
                      context,
                      "password",
                      "Mật khẩu",
                      (onValidateVal) {
                        if (onValidateVal.isEmpty) {
                          return "Mật khẩu không được để trống.";
                        }
                      },
                      (onSavedVal) {
                        password = onSavedVal;
                      },
                      borderFocusColor: Colors.black,
                      prefixIconColor: Colors.black,
                      borderColor: Colors.black,
                      textColor: Colors.black,
                      hintColor: Colors.black.withOpacity(0.7),
                      borderRadius: 10,
                      showPrefixIcon: true,
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      obscureText: hidePassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25, top: 10),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Quên mật khẩu',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Forget Password');
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: FormHelper.submitButton(
                      'Đăng nhập',
                      () {
                        if (validateAndSave()) {
                          setState(() {
                            isAPICallProcess = true;
                          });

                          LoginRequestModel model = LoginRequestModel(
                              phonenumber: phonenumber!, password: password!);

                          APIService.login(model).then((response) {
                            setState(() {
                              isAPICallProcess = false;
                            });

                            if (response) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/home', (route) => false);
                            } else {
                              FormHelper.showSimpleAlertDialog(
                                  context,
                                  Config.appName,
                                  "Số điện thoại hoặc mật khẩu không hợp lệ!",
                                  "OK", () {
                                Navigator.pop(context);
                              });
                            }
                          });
                        }
                      },
                      btnColor: HexColor('#283B71'),
                      borderColor: Colors.black,
                      txtColor: Colors.black,
                      borderRadius: 10,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Hoặc',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25, top: 10),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: "Không có tài khoản? "),
                            TextSpan(
                              text: 'Đăng ký',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, '/register');
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}

// const bool kReleaseMode = bool.fromEnvironment('dart.vm.product');
// const bool kProfileMode = bool.fromEnvironment('dart.vm.profile');
// const bool kDebugMode = !kReleaseMode && !kProfileMode;

// class LoginPage extends StatelessWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   static const String _title = 'StudentNet';

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//         title: _title,
//         home: Scaffold(
//           body: LoginPageBody(),
//         ));
//   }
// }

// class LoginPageBody extends StatefulWidget {
//   const LoginPageBody({Key? key}) : super(key: key);

//   @override
//   State<LoginPageBody> createState() => _LoginPageBodyState();
// }

// class _LoginPageResponse {
//   final String id;
//   final String username;
//   final String token;
//   final String avatar;
//   final String active;

//   const _LoginPageResponse({
//     required this.id,
//     required this.username,
//     required this.token,
//     required this.avatar,
//     required this.active,
//   });

//   factory _LoginPageResponse.fromJSON(Map<String, dynamic> json) {
//     return _LoginPageResponse(
//         id: json['id'],
//         username: json['username'],
//         token: json['token'],
//         avatar: json['avatar'],
//         active: json['active'],
//     );
//   }
// }

// class _LoginPageBodyState extends State<LoginPageBody> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Card(
//         child: ListView(
//           children: <Widget>[
//             Container(
//               alignment: Alignment.center,
//               padding: const EdgeInsets.all(10),
//               child: const Text(
//                 'StudentNet',
//                 style: TextStyle(
//                   color: Colors.blue,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 30,
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(10),
//               child: TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Số điện thoại',
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//               child: TextField(
//                 obscureText: true,
//                 controller: passwordController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Mật khẩu',
//                 ),
//               ),
//             ),
//             Container(
//               // height: 50,
//               padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
//               child: ElevatedButton(
//                 child: const Text('Đăng nhập'),
//                 onPressed: () {
//                   if (kDebugMode) {
//                     debugPrint(nameController.text);
//                     debugPrint(passwordController.text);
//                   }

//                   // Work with API LoginPage
//                   setState(() {
//                     _loginPageInfo = _loginPage(nameController.text, passwordController.text);
//                   });
//                 },
//               ),
//             ),
//             TextButton(
//                 onPressed: () {
//                   // Work with API Forgot Password
//                 },
//                 child: const Text('Quên mật khẩu?')
//             ),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 // const Text('Does not have account?'),
//                 TextButton(
//                     child: const Text(
//                       'Tạo tài khoản mới',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     onPressed: (){
//                       _navigateToSignUp(context);
//                     })
//               ],
//             ),
//           ],
//         ),
//       )

//     );
//   }

//   void _navigateToSignUp(BuildContext context) {
//     Navigator.of(context)
//         .push(MaterialPageRoute(builder: (context) => const SignUp()));
//   }

//   Future<_LoginPageResponse> _loginPage(String phoneNumber, String password) async {
//     final response = await http.post(
//       Uri.parse('http://184.169.213.180:3000/it4788/auth/loginPage'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'phonenumber': phoneNumber,
//         'password': password,
//       }),
//     );

//     if (response.statusCode == 1000) {
//       // If the server did return a 200 OK response,
//       // then parse the JSON.
//       return _LoginPageResponse.fromJSON(jsonDecode(response.body));
//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to loginPage');
//     }
//   }
// }

