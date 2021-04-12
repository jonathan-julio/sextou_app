import 'dart:convert';

import 'package:flutter/material.dart';
import 'registerPage.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

Future<bool> loginUser(String email, String password) async {
  var response = await http.post(
      Uri.parse("https://b2d4790c4c64.ngrok.io/sessions"),
      headers: {"Accept": "application/json"},
      body: {'email': email, 'password': password});
  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception(json.decode(response.body)['mesage']);
  }

  // otem os dados JSON
  //data = json.decode(response.body)['results'];
}

class LoginPage extends StatelessWidget {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            TextFormField(
              onChanged: (text) {
                email = text;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              onChanged: (text) {
                password = text;
              },
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: FlatButton(
                  child: Text("Esqueceu a senha?"),
                  textColor: Colors.redAccent,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => RegisterPage()));
                  }),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  )),
              child: SizedBox.expand(
                child: FlatButton(
                  onPressed: () async {
                    try {
                      await loginUser(email, password);
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MyHomePage(title: "sextou")));*/
                    } catch (error) {
                      print(error);
                    }
                  },
                  child: Text(
                    "Entrar",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              child: FlatButton(
                child: Text(
                  "Ainda não possui uma conta?",
                  style: TextStyle(color: Colors.grey),
                ),
                textColor: Colors.redAccent,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => RegisterPage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
