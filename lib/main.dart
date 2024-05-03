import 'package:flutter/material.dart';
import 'package:routing_router/pages/intro_page.dart';
import 'package:routing_router/pages/home_page.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.amber),
      home: const IntroPage(),
      routes: {
        '/homepage': (context) => const HomePage(),
        '/intropage': (context) => const IntroPage(),
      },
    );
  }
}
