import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamup/models/event.dart';
import 'package:teamup/models/user.dart';
import 'package:teamup/resources/auth_methods.dart';
import 'package:teamup/resources/event_methods.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return Scaffold(appBar: AppBar(title: Text('Home')), body: Center(
      child: Column(children: [Text('Home'), ElevatedButton(onPressed: () {AuthMethods().signOut();}, child: Text('Sign Out')), 
      ElevatedButton(onPressed: () async {
        String? res = await EventMethods().createEvent(
            user: user!, 
            title: 'Parc Villeray Soccer 5v5', 
            description: 'Friends match 5v5 on the small field', 
            sport: 'Hockey', 
            location: 'Parc Villeray', 
            startTime: DateTime(2025, 1, 23, 16, 30), 
            endTime: DateTime(2025, 1, 23, 18, 00));
        print('Event created with id: $res');
        MyEvent? event = await EventMethods().getEventByEid(res!);
        print(event?.description);
          }, 
        child: Text('Create event!'))],)));
  }
}