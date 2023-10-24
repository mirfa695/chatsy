import 'package:chatsy/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final _firebase = FirestoreServices();
  late final List listsend;
  Future getMessages(String message, String rid, BuildContext context) async {
    try {
      await _firebase.messages(message, rid);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChats(
      BuildContext context, String rid) {
    try {
      var data = _firebase.getMessages(rid);
      notifyListeners();
      return data;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      throw 'Error';
    }
  }

  Stream receiveChat(String rid, BuildContext context) {
    try {
      var data = _firebase.getReceive(rid);
      notifyListeners();
      return data;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      throw 'error';
    }
  }
}
