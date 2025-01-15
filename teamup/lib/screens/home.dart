import 'package:flutter/material.dart';
import 'package:teamup/resources/auth_methods.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Home')), body: Center(
      child: Column(children: [Text('Home'), ElevatedButton(onPressed: () {AuthMethods().signOut();}, child: Text('Sign Out')),],)));
  }
}