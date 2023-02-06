import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:student_net/config.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isAPICallProcess = false;
  bool hidePassword = true;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Config.hexColor5,
        body: _welcomeUI(context),
      ),
    );
  }

  Widget _welcomeUI(BuildContext context) {
    // Screen size of SafeArea
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double screenHeight = height - padding.top - padding.bottom;
    double screenWidth = MediaQuery.of(context).size.width;

    double textBoxHeight = 50;
    double textBoxWidth = screenWidth - 25 * 2;
    double textBoxBorderRadius = 10;

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
                padding: const EdgeInsets.only(top: 80),
                child: Center(
                  child: SizedBox(
                    width: textBoxWidth,
                    height: textBoxHeight,
                    child: FormHelper.submitButton(
                      'Đăng nhập',
                      () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      },
                      btnColor: Colors.white,
                      borderColor: Colors.white,
                      txtColor: Config.textColor2,
                      borderRadius: textBoxBorderRadius,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: SizedBox(
                    width: textBoxWidth,
                    height: textBoxHeight,
                    child: FormHelper.submitButton(
                      'Đăng ký',
                      () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/signup', (route) => false);
                      },
                      btnColor: Colors.transparent,
                      borderColor: Colors.white,
                      txtColor: Config.textColor1,
                      borderRadius: textBoxBorderRadius,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
