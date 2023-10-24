import 'package:chatsy/custom_widgets/custom_textfield.dart';
import 'package:chatsy/provider/chat_provider.dart';
import 'package:chatsy/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  ChatPage({this.name, this.image, Key? key, this.id}) : super(key: key);
  String? name;
  String? image;
  String? id;
  final TextEditingController textEditingController = TextEditingController();
  var authUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(image ?? Constants.defaultImage),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(name ?? 'user'),
            ],
          )),
      body: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            right: 8,
            left: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                  stream:
                      context.read<ChatProvider>().receiveChat(id!, context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var inf =
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return data;
                      }).toList();
                      // var gif=inf.where((map) => map["receiver_id"] == id)
                      //     .map((map) => map["message"].toString())
                      //     .toList();
                      // var gin=inf.where((map) => map["sender_id"] == id)
                      //     .map((map) => map["message"].toString())
                      //     .toList();
                      // print(gif);
                      return SizedBox(
                        height: 560,
                        child: ListView.separated(
                          itemCount: inf.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Align(
                                alignment: inf[index]["sender_id"] == id
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Container(
                                  color: Colors.black.withOpacity(.5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      inf[index]["message"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                  ),
                                ));
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 5,
                            );
                          },
                        ),
                      );
                    } else {
                      return const Text('error');
                    }
                  }),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomTextField(
                    controller: textEditingController,
                    eye: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          await context.read<ChatProvider>().getMessages(
                              textEditingController.text, id ?? '', context);
                          textEditingController.clear();
                        },
                        child: const Icon(Icons.send),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
