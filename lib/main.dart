import 'package:flutter/material.dart';
import 'package:student_net/models/settings/user_model.dart';

// import 'package:student_net/pages/homepage.dart';

import 'package:student_net/pages/auth/login.dart';
import 'package:student_net/pages/auth/verify.dart';
import 'package:student_net/pages/auth/welcome.dart';
import 'package:student_net/pages/postbaiviet/postbaiviet.dart';
import 'package:student_net/pages/auth/signup.dart';
import 'package:student_net/pages/main_app/chat_page.dart';
import 'package:student_net/pages/main_app/home_page.dart';
import 'package:student_net/pages/main_app/profile_page.dart';
import 'package:student_net/pages/main_app/root_app.dart';
import 'package:student_net/pages/main_app/video_page.dart';
import 'package:student_net/pages/search/saved_search.dart';
import "package:student_net/pages/search/search_bar.dart";
import 'package:student_net/pages/settings/main_menu.dart';
import 'package:student_net/pages/settings/block.dart';
import 'package:student_net/pages/settings/profile.dart';
import 'package:student_net/pages/settings/main_home.dart';

void main() {
  UserModel.readJson();
  runApp(const FinalApp());

  // runApp(const MyApp());
  // runApp(FbCloneProfileStless());
  // runApp(Example());
  // runApp(BlockPage());
}

class FinalApp extends StatelessWidget {
  const FinalApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Network',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // Define routes to pages
      routes: {
        // First page in app
        // '/': (context) => const WelcomePage(),
        '/': (context) => const LoginPage(),

        // Main pages in app
        '/root': (context) => const RootApp(),
        '/home': (context) => const HomePage(),
        '/chat': (context) => const ChatPage(),
        '/profile': (context) => const ProfilePage(),
        '/video': (context) => const VideoPage(),

        // Pages for functions
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/verify': (context) => const VerifyPage(),
        '/post': (context) => const PostBaiViet(),
        '/search': (context) => Example(),
      },
    );
  }
}
