import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var authUser = FirebaseAuth.instance.currentUser;

  Future registerUser(String name, String description, String image) async {
    await _firestore
        .collection('Users')
        .doc(authUser!.uid)
        .set({'name': name, 'description': description, 'image': image});
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('Users').doc(authUser!.uid).get();
    if (snapshot.exists) {
      return snapshot;
    } else {
      throw 'Error';
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPeople() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('Users').get();
    return snapshot;
  }

  Future messages(String message, String rid) async {
    await _firestore.collection('messages').add({
      'message': message,
      'sender_id': authUser!.uid,
      'receiver_id': rid,
      "time": DateTime.now().millisecondsSinceEpoch
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String rid) {
    var snapshot = _firestore
        .collection('messages')
        .where('sender_id', isEqualTo: authUser!.uid)
        .where('receiver_id', isEqualTo: rid)
        .orderBy("time", descending: false)
        .snapshots();
    return snapshot;
  }

  Stream getReceive(String rid) {
    var snapshot = _firestore
        .collection('messages')
        .where('sender_id', whereIn: [authUser!.uid, rid])
        .orderBy("time", descending: false)
        .snapshots();
    return snapshot;
  }
}
