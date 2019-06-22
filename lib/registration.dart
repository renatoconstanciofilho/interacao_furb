import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  RegistrationPage createState() => RegistrationPage();
}

class RegistrationPage extends State<Registration> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SharedPreferences sharedPreferences;
  TextEditingController firstname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController email = new TextEditingController();
  bool validFirstname = false;
  bool validLastname = false;
  bool validEmail = false;
  bool autoValidate = false;

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro do usuário'),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          autovalidate: autoValidate,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: firstname,
                  decoration: InputDecoration(labelText: 'Nome'),
                  keyboardType: TextInputType.text,
                  validator: validateFirstname,
                  onSaved: (String value) {
                    firstname.text = value;
                  },
                ),
                TextFormField(
                  controller: lastname,
//                  initialValue: lastname,
                  decoration: InputDecoration(labelText: 'Sobrenome'),
                  keyboardType: TextInputType.text,
                  validator: validateLastname,
                  onSaved: (String value) {
                    lastname.text = value;
                  },
                ),
                TextFormField(
                  controller: email,
//                  initialValue: email,
                  decoration: InputDecoration(labelText: 'Nome'),
                  keyboardType: TextInputType.text,
                  validator: validateEmail,
                  onSaved: (String value) {
                    email.text = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton.icon(
                    onPressed: () {
                      validateInputs();
                      saveSharedPrefs();
                    },
                    icon: Icon(Icons.save),
                    label: Text('Salvar'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  getSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    firstname.text = sharedPreferences.getString('firstname');
    lastname.text = sharedPreferences.getString('lastname');
    email.text = sharedPreferences.getString('email');
  }

  saveSharedPrefs() async {
    if(validFirstname && validLastname && validEmail) {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('firstname', firstname.text.toString());
      sharedPreferences.setString('lastname', lastname.text.toString());
      sharedPreferences.setString('email', email.text.toString());
      print(sharedPreferences.getString('firstname'));
      print(sharedPreferences.getString('lastname'));
      print(sharedPreferences.getString('email'));
      showToast('Dados salvos com sucesso');
    } else {
      showToast('Não salvo, favor corrigir os dados');
    }
  }

  void showToast(String msg) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
  }

  String validateFirstname(String value) {
    if (value.length < 3) {
      validFirstname = false;
      return 'Deve contar mais de 3 caracteres';
    } else if (value.contains(new RegExp(r'[0-9\W+]'))) {
      validFirstname = false;
      return 'Não deve conter números';
    } else {
      validFirstname = true;
      return null;
    }
  }

  String validateLastname(String value) {
    if (value.length < 4) {
      validLastname = false;
      return 'Deve contar mais de 3 caracteres';
    } else if (value.contains(new RegExp(r'[0-9]'))) {
      validLastname = false;
      return 'Não deve conter números';
    } else {
      validLastname = true;
      return null;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      validEmail = false;
      return 'Digite um email válido';
    } else {
      validEmail = true;
      return null;
    }
  }

  void validateInputs() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      setState(() {
        autoValidate = true;
      });
    }
  }
}
