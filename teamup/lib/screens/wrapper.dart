import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamup/models/user.dart';
import 'package:teamup/screens/authenticate/authenticate.dart';
import 'package:teamup/screens/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<MyUser?>(context);

    // Return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}