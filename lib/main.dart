import 'package:flutter/material.dart';

// import 'package:student_net/pages/homepage.dart';

import 'package:student_net/pages/auth/login.dart';
import 'package:student_net/pages/postbaiviet/postbaiviet.dart';
import 'package:student_net/pages/main_app/chat_page.dart';
import 'package:student_net/pages/main_app/home_page.dart';
import 'package:student_net/pages/main_app/profile_page.dart';
import 'package:student_net/pages/main_app/root_app.dart';
import 'package:student_net/pages/main_app/saved_page.dart';
import 'package:student_net/pages/search/saved_search.dart';
import "package:student_net/pages/search/search_bar.dart";
import 'package:student_net/pages/settings/main_menu.dart';
import 'package:student_net/pages/settings/block.dart';
import 'package:student_net/pages/settings/profile.dart';
import 'package:student_net/pages/settings/main_home.dart';

void main() {
  runApp(const MyApp());
  // runApp(FbCloneProfileStless());
  // runApp(Example());
  // runApp(BlockPage());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        // '/register': (context) => const RegisterPage(),
        '/root': (context) => const RootApp(),
        '/chat': (context) => const ChatPage(),
        '/profile': (context) => const ProfilePage(),
        '/saved': (context) => const SavedPage(),
        '/post': (context) => const PostBaiViet(),
      },
    );
  }
}
