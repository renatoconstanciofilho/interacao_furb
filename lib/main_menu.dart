import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:toast/toast.dart';

class MainMenu extends StatefulWidget {
  MainMenuPage createState() => MainMenuPage();
}

class MainMenuPage extends State<MainMenu> {

  String firstname;
  String lastname;
  String email;

//  MainMenu({Key key, @required this.firstname, this.lastname, this.email }) : super(key:key);

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
              title: Text('Presença via QR Code'),
              onTap: (){
                setState(() {
                  QRCodeReader()
                      .setAutoFocusIntervalInMs(200)
                      .setForceAutoFocus(true)
                      .setTorchEnabled(true)
                      .setHandlePermissions(true)
                      .setExecuteAfterPermissionGranted(true)
                      .scan().then((s) {
                        showToast('Presença confirmada no evento: ' + s);
                        print(s);
                      });
                });
              },
            ),
          )
        ],
      ),
    );
  }
  void showToast(String msg) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }
}
