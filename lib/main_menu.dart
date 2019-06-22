import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  MainMenuPage createState() => MainMenuPage();
}

class MainMenuPage extends State<MainMenu> {

  SharedPreferences sharedPreferences;
  TextEditingController firstname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController email = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

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
              leading: Icon(Icons.person),
              title: Text('Listar Eventos'),
              onTap: (){
                Navigator.pushNamed(context, '/list');
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
//                        Utilizar o firstname.text.toString(), lastname... email... para confirmar a presença
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

  getSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    firstname.text = sharedPreferences.getString('firstname');
    lastname.text = sharedPreferences.getString('lastname');
    email.text = sharedPreferences.getString('email');
  }

  void showToast(String msg) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }
}
