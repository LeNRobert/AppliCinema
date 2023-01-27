import 'dart:convert';
import 'package:flutter_application_1/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class FilmPage extends StatefulWidget {
  int id;
  String name;
  String biography = '';
  String birthday = '';
  double popularity = 0;
  String profilePath = '';

  FilmPage({super.key, this.id = 0, this.name = '???'});

  @override
  State<FilmPage> createState() => _FilmPage();
}

class _FilmPage extends State<FilmPage> {
  List webdata = [];

  Future<String> getData() async {
    var url = Uri.https('api.themoviedb.org', '/3/person/${widget.id}');

    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMmE0Y2YxZDUwNzlkOTMwYzA3YmVjYmJhZTBjNDI4YyIsInN1YiI6IjYwM2U5ZjE3ODQ0NDhlMDAzMDBlZWQwNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9CBeYye4C17jp29j77VjChML6ZJLwObLSolQW2GAhU4'
    });

    setState(() {
      Map<String, dynamic> root = jsonDecode(response.body);
      widget.biography = root['biography'];
      widget.birthday = root['birthday'];
      widget.popularity = root['popularity'];
      widget.profilePath = root['profile_path'];
    });

    url =
        Uri.https('api.themoviedb.org', '/3/person/${widget.id}/movie_credits');

    response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMmE0Y2YxZDUwNzlkOTMwYzA3YmVjYmJhZTBjNDI4YyIsInN1YiI6IjYwM2U5ZjE3ODQ0NDhlMDAzMDBlZWQwNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9CBeYye4C17jp29j77VjChML6ZJLwObLSolQW2GAhU4'
    });

    setState(() {
      Map<String, dynamic> root = jsonDecode(response.body);
      webdata = root['cast'];
    });

    return 'ok';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    widget.name = arguments['name'];
    widget.id = arguments['id'];

    getData();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      drawer: HomeDrawer(),
      body: Column(
        children: <Widget>[
          FadeInImage.assetNetwork(
              placeholder: 'assets/person_icon.png',
              image:
                  'https://www.themoviedb.org/t/p/w100_and_h100_bestv2${widget.profilePath}'),
          Text('Birthday: ${widget.birthday}'),
          SizedBox(height: 10),
          Text('Popularity: ${widget.popularity.toString()}'),
          SizedBox(height: 10),
          Text(
            'Biography',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(widget.biography),
          Text(
            'Films: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Expanded(
              child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                      itemCount: webdata.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, "DetailPage",
                                  arguments: {
                                    "id": webdata[index]["id"],
                                    "title": webdata[index]["title"]
                                  });
                            },
                            leading: FadeInImage.assetNetwork(
                                placeholder: 'assets/person_icon.png',
                                image:
                                    "https://www.themoviedb.org/t/p/w92${webdata[index]["poster_path"]}"),
                            title: Text(webdata[index]['title']),
                            subtitle: Text(webdata[index]['character']),
                          )))),
        ],
      ),
    );
  }
}
