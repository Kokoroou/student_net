import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'dart:io';

import 'package:student_net/config.dart';
import 'package:student_net/models/auth/login_model.dart';
import 'package:student_net/models/auth/signup_model.dart';
import 'package:student_net/services/api_service.dart';

// class SignUp extends StatelessWidget {
//   const SignUp({Key? key}) : super(key: key);

//   static const String _title = '_Name_App';
//   static const primaryColor = Color.fromARGB(255, 255, 132, 167);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: _title,
//       home: Scaffold(
//         // appBar: AppBar(
//         //     title: const Text(_title),
//         //     backgroundColor: primaryColor,
//         // ),
//         body: MyStatefulWidget(),
//       ),
//     );
//   }
// }

// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);

//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   TextEditingController UsernameController = TextEditingController();
//   TextEditingController RealnameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController EmailController = TextEditingController();
//   TextEditingController RepasswordController = TextEditingController();
//   TextEditingController dateInput = TextEditingController();
//   var gender = ['Male', 'FeMale', 'other'];
//   String dropdownvalue = 'Male';
//   Image icon = Image(
//       image: AssetImage('favicon.png'),
//       width: 100,
//       height: 100,
//       fit: BoxFit.fill);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
//         child: ListView(
//           children: <Widget>[
//             Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
//                 child: icon),

//             Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
//                 child: const Text(
//                   'App Name',
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 223, 80, 142),
//                       fontWeight: FontWeight.w900,
//                       fontSize: 30),
//                 )),
//             Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
//                 child: const Text(
//                   'Create a new account',
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 0, 0, 0),
//                       fontWeight: FontWeight.w500,
//                       fontSize: 15),
//                 )),
//             Container(
//               padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
//               height: 45,
//               child: TextField(
//                 style: TextStyle(fontSize: 14),
//                 controller: UsernameController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'User Name',
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
//               height: 45,
//               child: TextField(
//                 style: TextStyle(fontSize: 14),
//                 controller: RealnameController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Real Name',
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
//               height: 45,
//               child: TextField(
//                 style: TextStyle(fontSize: 14),
//                 controller: EmailController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Email or phone number',
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
//               height: 45,
//               child: TextField(
//                 style: TextStyle(fontSize: 14),
//                 obscureText: true,
//                 controller: passwordController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Password',
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
//               height: 45,
//               child: TextField(
//                 style: TextStyle(fontSize: 14),
//                 obscureText: true,
//                 controller: RepasswordController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'RePassword',
//                 ),
//               ),
//             ),
//             Container(
//                 padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
//                 child: Center(
//                     heightFactor: 0.5,
//                     child: TextField(
//                       style: TextStyle(fontSize: 14),
//                       controller: dateInput,
//                       //editing controller of this TextField
//                       decoration: InputDecoration(
//                           icon: Icon(Icons.calendar_today), //icon of text field
//                           labelText: "Birth Date" //label text of field
//                           ),
//                       readOnly: true,
//                       //set it true, so that user will not able to edit text
//                       onTap: () async {
//                         DateTime? pickedDate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(1950),
//                             //DateTime.now() - not to allow to choose before today.
//                             lastDate: DateTime(2100));

//                         if (pickedDate != null) {
//                           setState(() {
//                             dateInput.text = pickedDate
//                                 .toString(); //set output date to TextField value.
//                           });
//                         } else {}
//                       },
//                     ))),
//             Row(
//               children: <Widget>[
//                 const Text('Gender: '),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
//                   child: Column(
//                     children: [
//                       DropdownButton(
//                         value: dropdownvalue,
//                         icon: const Icon(Icons.keyboard_arrow_down),
//                         items: gender.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Text(items),
//                           );
//                         }).toList(),
//                         // After selecting the desired option,it will
//                         // change button value to selected value
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             dropdownvalue = newValue!;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//               mainAxisAlignment: MainAxisAlignment.center,
//             ),
//             // ),
//             Container(
//                 height: 45,
//                 padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
//                 child: ElevatedButton(
//                   child: const Text('Commit'),
//                   onPressed: () {
//                     print(UsernameController.text);
//                     // print(RealnameController.text);
//                     // print(EmailController.text);
//                     // print(passwordController.text);
//                     // print(RepasswordController.text);
//                     // print(dateInput.text);
//                     // print(dropdownvalue);
//                   },
//                   style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(
//                         Color.fromARGB(255, 255, 132, 167),
//                       ),
//                       textStyle: MaterialStateProperty.all(TextStyle(
//                         fontSize: 20,
//                         color: Colors.white,
//                       ))),
//                 )),
//             Row(
//               children: <Widget>[
//                 const Text('Does have account?'),
//                 TextButton(
//                   child: const Text(
//                     'Sign in',
//                     style: TextStyle(fontSize: 15, color: Colors.pink),
//                   ),
//                   onPressed: () {
//                     //signup screen
//                   },
//                 )
//               ],
//               mainAxisAlignment: MainAxisAlignment.center,
//             ),
//           ],
//         ));
//   }
// }

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  bool hideRePassword = true;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String? phonenumber;
  String? password;
  String? rePassword;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Config.hexColor5,
        body: ProgressHUD(
          inAsyncCall: isAPICallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: _signUpUI(context),
          ),
        ),
      ),
    );
  }

  Widget _signUpUI(BuildContext context) {
    // Screen size of SafeArea
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double screenHeight = height - padding.top - padding.bottom;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Config.hexColor1,
            Config.hexColor4,
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: (screenHeight - 470) / 2,
                ),
                child: const Center(
                  child: Text(
                    "Đăng ký",
                    style: TextStyle(
                      color: Config.textColor1,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: FormHelper.inputFieldWidget(
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
                  borderFocusColor: Colors.white,
                  prefixIconColor: Colors.white,
                  borderColor: Colors.white,
                  textColor: Colors.white,
                  hintColor: Colors.white.withOpacity(0.7),
                  borderRadius: 10,
                  showPrefixIcon: true,
                  prefixIcon: const Icon(Icons.phone),
                  isNumeric: true,
                ),
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
                  borderFocusColor: Colors.white,
                  prefixIconColor: Colors.white,
                  borderColor: Colors.white,
                  textColor: Colors.white,
                  hintColor: Colors.white.withOpacity(0.7),
                  borderRadius: 10,
                  showPrefixIcon: true,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility),
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: FormHelper.inputFieldWidget(
                  context,
                  "rePassword",
                  "Nhập lại mật khẩu",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return "Mật khẩu không được để trống.";
                    }
                  },
                  (onSavedVal) {
                    rePassword = onSavedVal;
                  },
                  borderFocusColor: Colors.white,
                  prefixIconColor: Colors.white,
                  borderColor: Colors.white,
                  textColor: Colors.white,
                  hintColor: Colors.white.withOpacity(0.7),
                  borderRadius: 10,
                  showPrefixIcon: true,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  obscureText: hideRePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hideRePassword = !hideRePassword;
                      });
                    },
                    icon: Icon(hideRePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 44),
                child: Center(
                  child: FormHelper.submitButton(
                    'Đăng ký',
                    () {
                      if (validateAndSave()) {
                        setState(() {
                          isAPICallProcess = true;
                        });

                        if (password == rePassword) {
                          SignupRequestModel model = SignupRequestModel(
                              phonenumber: phonenumber!, password: password!);

                          APIService.signup(model).then((response) {
                            setState(() {
                              isAPICallProcess = false;
                            });

                            print("--------------body: ${response}");

                            if (response["code"] == "1000") {
                              FormHelper.showSimpleAlertDialog(
                                  context,
                                  Config.appName,
                                  "Tạo tài khoản thành công",
                                  "OK", () {
                                Navigator.pop(context);
                              });
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/verify', (route) => false);
                            } else if (response["code"] == "9996") {
                              FormHelper.showSimpleAlertDialog(
                                  context,
                                  Config.appName,
                                  "Tài khoản đã tồn tại!",
                                  "OK", () {
                                Navigator.pop(context);
                              });
                            } else if (response["code"] == "1004") {
                              FormHelper.showSimpleAlertDialog(
                                  context,
                                  Config.appName,
                                  "Tên đăng nhập hoặc mật khẩu không hợp lệ!",
                                  "OK", () {
                                Navigator.pop(context);
                              });
                            }
                          });
                        } else {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Các mật khẩu đã nhập không khớp!",
                              "OK", () {
                            Navigator.pop(context);

                            // Fix error: Unknown loading
                            Navigator.pushNamed(context, '/signup');
                          });
                        }
                      }
                    },
                    btnColor: Colors.white,
                    borderColor: Colors.white,
                    txtColor: Config.textColor2,
                    borderRadius: 10,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: (screenHeight - 350) / 2),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Config.textColor2,
                        fontSize: 14.0,
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: "Đã có tài khoản? "),
                        TextSpan(
                          text: 'Đăng nhập',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/login');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
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

  bool validatePassword() {
    return true;
  }
}
