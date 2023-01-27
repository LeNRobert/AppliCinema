import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        // ignore: prefer_const_literals_to_create_immutables
        child: ListView(children: [
      const DrawerHeader(
          decoration: BoxDecoration(color: Colors.red),
          child: Text('Menu',
              style: TextStyle(color: Colors.white, fontSize: 28.0))),
      ListTile(
        leading: Icon(Icons.thumb_up),
        title: Text('Acteurs populaires'),
        onTap: () {
          Navigator.pushNamed(context, '/');
        },
      ),
      ListTile(
        leading: Icon(Icons.info),
        title: Text('A propos'),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('A propos'),
                  content: Text('Cette application a été développée par LE'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Fermer'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        },
      ),
      ListTile(
        title: Text(''),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  //content: Text("Cette application a été développée par LE"),
                  content: Image.asset('assets/gif.gif'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Fermer'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        },
      ),
    ]));
  }
}
