// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List webdata = [];
  bool _isSearching = false;
  String _searchQuery = '';

  Future<String> getData() async {
    var url = Uri.https('api.themoviedb.org', '/3/person/popular');

    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMmE0Y2YxZDUwNzlkOTMwYzA3YmVjYmJhZTBjNDI4YyIsInN1YiI6IjYwM2U5ZjE3ODQ0NDhlMDAzMDBlZWQwNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9CBeYye4C17jp29j77VjChML6ZJLwObLSolQW2GAhU4'
    });

    setState(() {
      Map<String, dynamic> root = jsonDecode(response.body);
      // { "prop1": xxx }
      webdata = root['results'];
    });

    return 'ok';
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void _handleSearchInput(String input) {
    setState(() {
      _searchQuery = input;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onChanged: _handleSearchInput,
              )
            : Text(widget.title),
        actions: [
          _isSearching
              ? IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: 'Search',
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                      _searchQuery = '';
                    });
                  })
              : IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: 'Search',
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  })
        ],
      ),
      drawer: const HomeDrawer(),
      body: ListView.builder(
          itemCount: webdata.length,
          itemBuilder: (BuildContext context, int index) {
            if (_searchQuery.isNotEmpty &&
                !webdata[index]['name']
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase())) {
              return Container();
            }
            return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, 'FilmPage', arguments: {
                    'id': webdata[index]['id'],
                    'name': webdata[index]['name']
                  });
                },
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: FadeInImage.assetNetwork(
                        placeholder: 'assets/person_icon.png',
                        image:
                            "https://www.themoviedb.org/t/p/w100_and_h100_bestv2${webdata[index]["profile_path"]}")),
                title: Text(webdata[index]['name']));
          }),
    );
  }
}
