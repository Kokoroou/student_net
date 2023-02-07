import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:student_net/config.dart';
import 'package:student_net/models/auth/login_model.dart';
import 'package:student_net/models/auth/verify_model.dart';
import 'package:student_net/services/api_service.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_db_helper.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool isAPICallProcess = false;
  bool isGetVerifyCode = false;
  bool verifyOnlyPhonenumber = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String? phonenumber;
  String? codeVerify;

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
            child: _verifyUI(context),
          ),
        ),
      ),
    );
  }

  Widget _verifyUI(BuildContext context) {
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
                  top: (screenHeight - 350) / 2,
                ),
                child: const Center(
                  child: Text(
                    "Xác thực tài khoản",
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
                padding: const EdgeInsets.only(top: 10),
                child: isGetVerifyCode != true
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Center(
                          child: FormHelper.submitButton(
                            'Lấy mã xác thực',
                            () {
                              if (validateAndSave()) {
                                setState(() {
                                  isAPICallProcess = true;
                                });

                                GetVerifyRequestModel model =
                                    GetVerifyRequestModel(
                                        phonenumber: phonenumber!);

                                APIService.getVerify(model).then((response) {
                                  setState(() {
                                    isAPICallProcess = false;
                                  });

                                  print("--------------body: ${response}");

                                  if (response["code"] == "1000") {
                                    FormHelper.showSimpleAlertDialog(
                                        context,
                                        Config.appName,
                                        "Mã xác nhận của bạn là ${response["data"]["verifyCode"]}",
                                        "OK", () {
                                      Navigator.pop(context);
                                    });
                                    setState(() {
                                      isGetVerifyCode = true;
                                    });
                                  } else if (response["code"] == "9995") {
                                    FormHelper.showSimpleAlertDialog(
                                        context,
                                        Config.appName,
                                        "Không tìm thấy tài khoản!",
                                        "OK", () {
                                      Navigator.pop(context);
                                    });
                                  } else if (response["code"] == "1004") {
                                    FormHelper.showSimpleAlertDialog(
                                        context,
                                        Config.appName,
                                        "Số điện thoại không hợp lệ!",
                                        "OK", () {
                                      Navigator.pop(context);
                                    });
                                  } else if (response["code"] == "1010") {
                                    if (response["details"] ==
                                        "user is verified") {
                                      FormHelper.showSimpleAlertDialog(
                                          context,
                                          Config.appName,
                                          "Tài khoản đã xác thực!",
                                          "OK", () {
                                        Navigator.pop(context);
                                      });
                                    } else {
                                      FormHelper.showSimpleAlertDialog(
                                          context,
                                          Config.appName,
                                          "Vui lòng chờ ít nhất 2 phút trước khi lấy mã xác nhận lại!",
                                          "OK", () {
                                        Navigator.pop(context);
                                      });
                                    }
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
                      )
                    : Column(
                        children: [
                          FormHelper.inputFieldWidget(
                            context,
                            "codeVerify",
                            "Mã xác nhận",
                            (onValidateVal) {
                              if (!verifyOnlyPhonenumber) {
                                if (onValidateVal.isEmpty) {
                                  return "Mã xác nhận không được để trống.";
                                }
                              }
                            },
                            (onSavedVal) {
                              codeVerify = onSavedVal;
                            },
                            borderFocusColor: Colors.white,
                            prefixIconColor: Colors.white,
                            borderColor: Colors.white,
                            textColor: Colors.white,
                            hintColor: Colors.white.withOpacity(0.7),
                            borderRadius: 10,
                            showPrefixIcon: true,
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            isNumeric: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Center(
                              child: FormHelper.submitButton(
                                'Xác thực',
                                () {
                                  if (validateAndSave()) {
                                    setState(() {
                                      isAPICallProcess = true;
                                    });

                                    CheckVerifyRequestModel model =
                                        CheckVerifyRequestModel(
                                            phonenumber: phonenumber!,
                                            codeVerify: codeVerify!);

                                    APIService.checkVerify(model)
                                        .then((response) {
                                      setState(() {
                                        isAPICallProcess = false;
                                      });

                                      print("--------------body: ${response}");

                                      if (response["code"] == "1000") {
                                        FormHelper.showSimpleAlertDialog(
                                            context,
                                            Config.appName,
                                            "Đã xác thực tài khoản của bạn!",
                                            "OK", () {
                                          Navigator.pop(context);
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/login',
                                              (route) => false);
                                        });
                                      } else if (response["code"] == "1004") {
                                        if (response["details"] ==
                                            "user is verified") {
                                          FormHelper.showSimpleAlertDialog(
                                              context,
                                              Config.appName,
                                              "Tài khoản đã xác thực!",
                                              "OK", () {
                                            Navigator.pop(context);
                                          });
                                        } else {
                                          FormHelper.showSimpleAlertDialog(
                                              context,
                                              Config.appName,
                                              "SĐT/Mã xác nhận không đúng!",
                                              "OK", () {
                                            Navigator.pop(context);
                                          });
                                        }
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Config.textColor2,
                                    fontSize: 14.0,
                                  ),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: "Chưa có mã xác thực? "),
                                    TextSpan(
                                      text: 'Lấy mã',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          setState(() {
                                            verifyOnlyPhonenumber = true;
                                          });

                                          if (validateAndSave()) {
                                            setState(() {
                                              isAPICallProcess = true;
                                              verifyOnlyPhonenumber = false;
                                            });

                                            GetVerifyRequestModel model =
                                                GetVerifyRequestModel(
                                                    phonenumber: phonenumber!);

                                            APIService.getVerify(model)
                                                .then((response) {
                                              setState(() {
                                                isAPICallProcess = false;
                                              });

                                              print(
                                                  "--------------body: ${response}");

                                              if (response["code"] == "1000") {
                                                FormHelper.showSimpleAlertDialog(
                                                    context,
                                                    Config.appName,
                                                    "Mã xác nhận của bạn là ${response["data"]["verifyCode"]}",
                                                    "OK", () {
                                                  Navigator.pop(context);
                                                });
                                                setState(() {
                                                  isGetVerifyCode = true;
                                                });
                                              } else if (response["code"] ==
                                                  "9995") {
                                                FormHelper.showSimpleAlertDialog(
                                                    context,
                                                    Config.appName,
                                                    "Không tìm thấy tài khoản!",
                                                    "OK", () {
                                                  Navigator.pop(context);
                                                });
                                              } else if (response["code"] ==
                                                  "1004") {
                                                FormHelper.showSimpleAlertDialog(
                                                    context,
                                                    Config.appName,
                                                    "Số điện thoại không hợp lệ!",
                                                    "OK", () {
                                                  Navigator.pop(context);
                                                });
                                              } else if (response["code"] ==
                                                  "1010") {
                                                if (response["details"] ==
                                                    "user is verified") {
                                                  FormHelper.showSimpleAlertDialog(
                                                      context,
                                                      Config.appName,
                                                      "Tài khoản đã xác thực!",
                                                      "OK", () {
                                                    Navigator.pop(context);
                                                  });
                                                } else {
                                                  FormHelper.showSimpleAlertDialog(
                                                      context,
                                                      Config.appName,
                                                      "Vui lòng chờ ít nhất 2 phút trước khi lấy mã xác nhận lại!",
                                                      "OK", () {
                                                    Navigator.pop(context);
                                                  });
                                                }
                                              }
                                            });
                                          }
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
              Padding(
                padding: EdgeInsets.only(top: (screenHeight - 350) / 2),
                child: isGetVerifyCode
                    ? Center(
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
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 80),
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
