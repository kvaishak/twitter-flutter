import 'package:flutter/material.dart';
import 'package:twitter/models/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:date_format/date_format.dart';

class Profile extends StatelessWidget {

  final Profiledata profiledata;
  Profile({Key key, @required this.profiledata}) : super(key: key);

  String _tweet(dynamic tweet){
    return tweet['tweet_text'];
  }

  String _time(dynamic tweet){
    return tweet['time'];
  }


  @override
  Widget build(BuildContext context) {

    final String apiUrl = "http://127.0.0.1:8282/user/tweets?username=" + profiledata.name;

    Future<List<dynamic>> fetchUsers() async {
      var result = await http.get(apiUrl);
      return json.decode(result.body);
      // final List<Tweets> TweetList = []
    }



    return Scaffold(
      appBar: AppBar(
        title: Text('@'+profiledata.name),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) => TweetCard(context, index, snapshot));
            }else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget TweetCard(BuildContext context, int index, AsyncSnapshot snapshot){
    return
     new Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.adjust_rounded, color: Colors.blue,),
                title: Text(_tweet(snapshot.data[index])),
                subtitle: Padding(
                  padding: const EdgeInsets.fromLTRB(0,20.0,0,0),
                  child: Text(formatDate(DateTime.parse(_time(snapshot.data[index])), [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ' ', am])),
                ),
                // subtitle: Text(_time(snapshot.data[index])),
              )
            ],
          ),
        ),
      );
  }
}