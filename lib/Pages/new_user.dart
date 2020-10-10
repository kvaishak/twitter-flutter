import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUser createState() => _NewUser();
}

class _NewUser extends State<NewUser> {
  @override
  Widget build(BuildContext context) {
    String _username;
    String _email;
    String _firstname;
    String _lastname;

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    Future<List<dynamic>> sendTweet() async {
      final String apiUrl = "http://localhost:8282/user/new";

      final response = await http.post(apiUrl,
          body: jsonEncode(<String, String>{
            'username': _username,
            'useremail': _email,
            'firstname': _firstname,
            'lastname': _lastname
          }));

      var msg = "User Successfully Created";
      var bgColor = Colors.green;
      if (response.statusCode != 200) {
        msg = "Error in creating new user. Please Try again";
        bgColor = Colors.red;
      }
      print(response.body);

      //Alert
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: bgColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    Widget _buildUsername() {
      return (new TextFormField(
        maxLines: 1,
        decoration: new InputDecoration(
          labelText: 'Enter desired Username',
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide: new BorderSide(),
          ),
          //fillColor: Colors.green
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return "Username is required";
          }
          return null;
        },
        onSaved: (String value) {
          _username = value;
        },
        keyboardType: TextInputType.emailAddress,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ));
    }

    Widget _buildEmail() {
      return (new TextFormField(
        maxLines: 1,
        decoration: new InputDecoration(
          labelText: 'Enter email',
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide: new BorderSide(),
          ),
          //fillColor: Colors.green
        ),

        validator: (String value) {
          if (value.isEmpty) {
            return "Email is required";
          }
          return null;
        },
        onSaved: (String value) {
          _email = value;
        },
        // keyboardType: TextInputType.emailAddress,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ));
    }

    Widget _buildFirstname() {
      return (new TextFormField(
        maxLines: 1,
        decoration: new InputDecoration(
          labelText: 'Enter your first name',
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide: new BorderSide(),
          ),
          //fillColor: Colors.green
        ),

        validator: (String value) {
          return null;
        },
        onSaved: (String value) {
          _firstname = value;
        },
        // keyboardType: TextInputType.emailAddress,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ));
    }

    Widget _buildLastname() {
      return (new TextFormField(
        maxLines: 1,
        decoration: new InputDecoration(
          labelText: 'Enter your last name',
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide: new BorderSide(),
          ),
          //fillColor: Colors.green
        ),

        validator: (String value) {
          return null;
        },
        onSaved: (String value) {
          _lastname = value;
        },
        // keyboardType: TextInputType.emailAddress,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ));
    }

    Widget _buildSubmit() {
      return new RaisedButton.icon(
        textColor: Colors.white,
        color: Colors.lightBlueAccent,
        onPressed: () {
          if (!_formKey.currentState.validate()) {
            return;
          }
          _formKey.currentState.save();
          sendTweet();
          _formKey.currentState.reset();
        },
        icon: Icon(Icons.accessibility, size: 20),
        label: Text("Create User"),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("New User"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildUsername(),
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  _buildEmail(),
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  _buildFirstname(),
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  _buildLastname(),
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  _buildSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
