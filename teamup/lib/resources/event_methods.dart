import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teamup/models/event.dart';
import 'package:teamup/models/user.dart';

class EventMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create an event - Returns the id of the event if successful, returns null if error
  Future<String?> createEvent({
    required MyUser user, 
    String title = 'Untitled Event', 
    String description = 'No description provided.', 
    String sport = 'N/A', 
    String access = 'private',
    required String location, 
    required DateTime startTime, 
    required DateTime endTime
    }) async {
    try {
      final DocumentReference docRef = await _firestore.collection('events').add({
        'title': title,
        'description': description,
        'sport': sport,
        'access': access,
        'location': location,
        'startTime': startTime.toUtc(),
        'endTime': endTime.toUtc(),
        'createdBy': user.uid,
        'admin': user.uid,
        'participants': [user.uid],
      });
      String eid = docRef.id;
      await _firestore.doc(docRef.path).update({
        'eid': eid,
      });

      // Add event to list of owned and participating events inside the user document
      await _firestore.collection('users').doc(user.uid).update(
        {
          'createdEvents': FieldValue.arrayUnion([docRef.id]), // List of events in which the user created
          'participatingEvents': FieldValue.arrayUnion([docRef.id]), // List of events in which the user is participating
          'adminEvents': FieldValue.arrayUnion([docRef.id]), // List of events in which the user is an admin
        });


      return eid;
    } catch (e) {
      print('Error creating event: ${e.toString()}');
      return null;
    }
  }

  // Get event by event id (eid)
  Future<MyEvent?> getEventByEid(String eid) async {
    try {
      // Fetch the document from Firestore
      final DocumentSnapshot docSnapshot = await _firestore.collection('events').doc(eid).get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // Get the document data as a Map
        final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

        // Map the data to a MyEvent object
        return MyEvent(
          eid: eid,
          uidCreatedBy: data['createdBy'] ?? '', // Use default value if field is missing
          uidAdmin: data['admin'] ?? '', // Use default value if field is missing
          participants: List<String>.from(data['participants'] ?? []), // Convert to List<String>
          title: data['title'] ?? '', // Use default value if field is missing
          description: data['description'] ?? '', // Use default value if field is missing
          location: data['location'] ?? '', // Use default value if field is missing
          sport: data['sport'] ?? '', // Use default value if field is missing
          startTime: (data['startTime'] as Timestamp).toDate(), // Convert Firestore Timestamp to DateTime
          endTime: (data['endTime'] as Timestamp).toDate(), // Convert Firestore Timestamp to DateTime
        );
      } else {
        // Document does not exist
        print('Event with eid $eid not found');
        return null;
      }
    } catch (e) {
      print('Error fetching event: ${e.toString()}');
      return null;
    }
  }

  // Modify event (requires event admin privileges)
  Future<bool?> modifyEvent(String uid, String eid, String param, dynamic newValue) async { // uid is the uid of user trying to perform action, eid is the event id, param is the parameter to be updated, newValue is the new value
    try {
      // Check if the user is an admin of the event
      final DocumentSnapshot docSnapshot = await _firestore.collection('events').doc(eid).get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // Get the document data as a Map
        final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        final dynamic eventAdminUser = data['admin'] ?? []; // Get the admin uid
        if (eventAdminUser == uid) {
          // User is an admin of the event
          // Since uid corresponds to an admin id, we can update the event type
          await _firestore.collection('events').doc(eid).update(
            {
              param: newValue, // Update with new sport
            });
          return true;
        } else {
          // User is not an admin of the event
          print('User with uid $uid is not an admin of the event with eid $eid');
          return false;
        }

      } else {
        // Document does not exist
        print('Event with eid $eid not found');
        return false;
      }
    } catch (e) {
      print('Error updating event type: ${e.toString()}');
    }
    return false;
  }

  // Delete event (requires event admin privileges)
  Future<bool?> deleteEvent(String uid, String eid) async {
    try {
      // Check if the user is an admin of the event
      final DocumentSnapshot docSnapshot = await _firestore.collection('events').doc(eid).get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // Get the document data as a Map
        final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        final dynamic eventAdminUser = data['admin'] ?? []; // Get the admin uid
        if (eventAdminUser == uid) {
          // User is an admin of the event
          // Delete the event
          await _firestore.collection('events').doc(eid).delete();
          return true;
        } else {
          // User is not an admin of the event
          print('User with uid $uid is not an admin of the event with eid $eid');
          return false;
        }

      } else {
        // Document does not exist
        print('Event with eid $eid not found');
        return false;
      }
    } catch (e) {
      print('Error deleting event: ${e.toString()}');
    }
    return false;
  }
}