import 'package:flutter_application_1/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  int _selectedIndex = 0;
  Map<String, dynamic> webdata = {};

  Future<String> getData(int id) async {
    var url = Uri.https("api.themoviedb.org", "/3/movie/$id",
        {"language": "fr-FR", "append_to_response": "videos"});

    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMmE0Y2YxZDUwNzlkOTMwYzA3YmVjYmJhZTBjNDI4YyIsInN1YiI6IjYwM2U5ZjE3ODQ0NDhlMDAzMDBlZWQwNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9CBeYye4C17jp29j77VjChML6ZJLwObLSolQW2GAhU4"
    });

    setState(() {
      webdata = jsonDecode(response.body);
    });

    return "ok";
  }

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: <Widget>[Text("ntm medina")]));
  }
}
