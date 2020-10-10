import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twitter/Pages/profile.dart';
import 'dart:convert';

import 'package:twitter/Pages/user_list.dart';

class NewUser extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New User'),
      ),
      body: Center(
        child: Container(
            child: Text("Holla Muchachoesss")
        ),
      ),
    );
  }
}