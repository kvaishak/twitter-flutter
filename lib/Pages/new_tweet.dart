import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class NewTweet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController tweetTextController = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('New Tweet'),
          ),
          body: new Container(
              child: new Container(
                  padding: const EdgeInsets.all(30.0),
                  color: Colors.white,
                  child: new Container(
                    child: new Center(
                        child: SingleChildScrollView(
                      child: new Column(children: [
                        InputFieldComponent("Username", usernameController),
                        new Padding(padding: EdgeInsets.only(top: 20.0)),
                        InputFieldComponent("Tweet Text", tweetTextController),
                        new Padding(padding: EdgeInsets.only(top: 20.0)),
                        SubmitButton(usernameController, tweetTextController),
                      ]),
                    )),
                  )))),
    );
  }

  Widget InputFieldComponent(String input, TextEditingController controller) {
    return (new TextField(
      maxLines: input == "Username" ? 1 : null,
      // keyboardType: input=="Username" ? TextInputType.text: TextInputType.multiline,
      decoration: new InputDecoration(
        labelText: 'Enter ${input}',
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(15.0),
          borderSide: new BorderSide(),
        ),
        //fillColor: Colors.green
      ),
      controller: controller,
      // keyboardType: TextInputType.emailAddress,
      style: new TextStyle(
        fontFamily: "Poppins",
      ),
    ));
  }

  Widget SubmitButton(
      TextEditingController usernameC, TextEditingController tweetTextC) {
    Future<List<dynamic>> sendTweet(String username, String tweetText) async {
      print(username);
      final String apiUrl = "http://127.0.0.1:8282/tweets/new";

      final response = await http.post(apiUrl,
          body: jsonEncode(
              <String, String>{'username': username, 'tweetText': tweetText}));

      var msg = "Tweet Successfully posted";
      var bgColor = Colors.green;
      if (response.statusCode != 200) {
        msg = "Error in posting tweet";
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

    return new RaisedButton.icon(
      textColor: Colors.white,
      color: Colors.lightBlueAccent,
      onPressed: () {
        // Send the data
        String username = usernameC.text;
        String tweetText = tweetTextC.text;
        sendTweet(username, tweetText);
        usernameC.clear();
        tweetTextC.clear();
      },
      icon: Icon(Icons.send, size: 20),
      label: Text("Tweet"),
    );
  }
}
