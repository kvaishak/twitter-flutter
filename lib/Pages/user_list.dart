import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:twitter/Pages/profile.dart';
import 'package:twitter/models/profile.dart';

class UserList extends StatelessWidget {
  final String apiUrl = "http://127.0.0.1:8282/users";

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(apiUrl);
    print(parseUsers(result.body).length);
    return json.decode(result.body);
  }

  List<Profiledata> parseUsers(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<Profiledata>((json) => Profiledata.fromJson(json))
        .toList();
  }

  String _name(dynamic user) {
    return user['firstname'] + " " + user["lastname"];
  }

  String _username(dynamic user) {
    return user['username'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print(_username(snapshot.data[0]));
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) =>
                      UserCard(context, index, snapshot));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget UserCard(BuildContext context, int index, AsyncSnapshot snapshot) {
    return new Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  "https://ssl.gstatic.com/accounts/ui/avatar_2x.png"),
            ),
            title: Text(_name(snapshot.data[index])),
            subtitle: Text("@" + _username(snapshot.data[index])),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profile(
                          profiledata: Profiledata(
                              name: _username(snapshot.data[index])),
                        )),
              );
            },
          )
        ],
      ),
    );
  }
}
