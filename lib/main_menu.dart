import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {

  String firstname;
  String lastname;
  String email;

  MainMenu({Key key, @required this.firstname, this.lastname, this.email }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Registro'),
              onTap: (){
                Navigator.pushNamed(context, '/register');
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Scanner QR Code'),
              onTap: (){

              },
            ),
          )
        ],
      ),
    );
  }

  }
