import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/film.dart';
import 'package:flutter_application_1/detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cinema',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        routes: {
          '/': (context) => MyHomePage(title: 'Cinema'),
          'FilmPage': (context) => FilmPage(),
          'DetailPage': (context) => DetailPage()
        });
  }
}
