import 'package:chatsy/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  DocumentSnapshot<Map<String, dynamic>>? data;
  String? user;
  var authUser = FirebaseAuth.instance.currentUser;

  Future<void> getUsers(BuildContext context) async {
    try {
      data = await FirestoreServices().getUser();
      user = data!["name"];
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>? getPeople(
      BuildContext context) async {
    try {
      var people = await FirestoreServices().getPeople();
      var listPeople =
          people.docs.where((element) => element.id != authUser!.uid).toList();
      notifyListeners();
      return listPeople;
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      throw 'Error';
    }
  }
}
