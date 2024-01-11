
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_using_provider/provider/todo_provider.dart';
import 'package:todo_using_provider/splash_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => TodoProvider(),
       child: MyApp(),
  ),
  );
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}


