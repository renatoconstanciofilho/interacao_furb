import 'package:flutter/material.dart';
import 'main_menu.dart';
import 'registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

String firstname;
String lastname;
String email;
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
  if (firstname != null)
    return '/';
  else
    return '/register';
}

getSharedPrefs() async {
  sharedPreferences = await SharedPreferences.getInstance();
    firstname = sharedPreferences.getString('firstname');
    lastname = sharedPreferences.getString('lastname');
    email = sharedPreferences.getString('email');
}