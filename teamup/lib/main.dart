import 'package:flutter/material.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:teamup/models/user.dart';
import 'package:teamup/resources/auth_methods.dart';
import 'package:teamup/screens/wrapper.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthMethods().user,
      child: MaterialApp(
        title: 'Team Up',
        theme: ThemeData.dark(),
        home: Wrapper(),
      ),
    //   home: ResponsiveLayout(
    //     webScreenLayout: WebScreenLayout(), 
    //     mobileScreenLayout: MobileScreenLayout()),
    );
  }
}