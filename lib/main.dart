import 'package:flutter/material.dart';
import 'main_menu.dart';
import 'registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController firstname = new TextEditingController();
TextEditingController lastname = new TextEditingController();
TextEditingController email = new TextEditingController();
SharedPreferences sharedPreferences;

void main() => runApp(MaterialApp(
        title: 'Interação FURB',
        theme: ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
        initialRoute: getStartupScreen(),
        routes: {
          '/': (context) => MainMenu(),
          '/register': (context) => Registration(),
        }));

String getStartupScreen(){
  getSharedPrefs();
  if (firstname.text.toString() != null)
    return '/';
  else
    return '/register';
}

getSharedPrefs() async {
  sharedPreferences = await SharedPreferences.getInstance();
    firstname.text = sharedPreferences.getString('firstname');
    lastname.text = sharedPreferences.getString('lastname');
    email.text = sharedPreferences.getString('email');
}