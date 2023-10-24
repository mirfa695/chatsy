import 'package:chatsy/provider/login_provider.dart';
import 'package:chatsy/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.read<LoginProvider>();
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new_sharp),
      )),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<ThemeProvider>().setTheme();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text('Change theme'),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Sign Out'),
                            content: const Text('Are you sure?'),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    await provider.signOut(context);
                                    await provider.setBool(false);
                                  },
                                  child: const Text('Yes')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No'))
                            ],
                          );
                        });
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text('Sign out'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
