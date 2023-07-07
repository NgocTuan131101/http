import 'package:flutter/material.dart';
import 'package:repositorypatterm/screens/home_screen.dart';

void main() {
  runApp(Application());
}
class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.orange[100],
        appBarTheme: AppBarTheme(
          elevation: 0.0,
        )
      ),
      home: HomeScreen(),
    );
  }
}
