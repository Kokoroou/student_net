import 'package:flutter/material.dart';
import 'package:student_net/pages/testData/post_json.dart';
import 'package:student_net/theme/colors.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(0)),
      // body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      backgroundColor: white,
      elevation: 0,
    );
  }
}
