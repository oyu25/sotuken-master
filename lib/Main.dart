 import 'package:flutter/material.dart';
import 'Home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'みやぎ方言アプリ',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
