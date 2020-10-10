import 'package:flutter/material.dart';
import 'package:twitter/Pages/user_list.dart';
import 'package:twitter/Pages/new_post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter Flutter app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _pushSaved(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    var function;
    if(_selectedIndex == 0){
      function = UserList();
    }else if(_selectedIndex == 1){
      function =  new PostList();
    }else{
      // function = _signOut();
    }


    return Scaffold(

      body: function,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_work_outlined),  title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline_rounded), title: Text('New Tweet')),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), title: Text('New User')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blueAccent,
        onTap: _pushSaved,
      ),
    );
  }
}
