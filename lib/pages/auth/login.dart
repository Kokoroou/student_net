import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:student_net/config.dart';
import 'package:student_net/models/auth/login_model.dart';
import 'package:student_net/services/api_service.dart';

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
        backgroundColor: Config.hexColor5,
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
                  top: (screenHeight - 270) / 2,
                ),
                child: const Center(
                  child: Text(
                    "Student Network",
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
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25, top: 10),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Quên mật khẩu',
                          style: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              FormHelper.showSimpleAlertDialog(
                                  context,
                                  Config.appName,
                                  "Hiện chưa hỗ trợ đổi mật khẩu!",
                                  "OK", () {
                                Navigator.pop(context);
                              });
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
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
                              context, '/root', (route) => false);
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
                  btnColor: Colors.white,
                  borderColor: Colors.white,
                  txtColor: Config.textColor2,
                  borderRadius: 10,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // const Center(
              //   child: Text(
              //     'Hoặc',
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 18,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25, top: 10),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Config.textColor2,
                        fontSize: 14.0,
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: "Không có tài khoản? "),
                        TextSpan(
                          text: 'Đăng ký ngay',
                          style: const TextStyle(
                            color: Colors.white,
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
}
