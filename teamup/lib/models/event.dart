class MyEvent {
  final String eid;
  final String uidCreatedBy;
  String uidAdmin;
  List<String> participants;
  String title = '';
  String description = '';
  final String location;
  final DateTime startTime;
  final DateTime endTime;

  MyEvent({required this.eid, required this.uidCreatedBy, required this.uidAdmin, required this.participants, required this.title, required this.description, required this.location, required this.startTime, required this.endTime});
}






//     required MyUser user, 
//     String title = 'Untitled Event', 
//     String description = 'No description provided.', 
//     String sport = 'N/A', 
//     required String location, 
//     required DateTime startTime, 
//     required DateTime endTime


        // 'title': title,
        // 'description': description,
        // 'sport': sport,
        // 'location': location,
        // 'startTime': startTime.toUtc(),
        // 'endTime': endTime.toUtc(),
        // 'createdBy': user.uid,
        // 'admin': user.uid,
        // 'participants': [user.uid],