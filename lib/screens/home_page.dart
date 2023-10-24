import 'package:chatsy/custom_widgets/custom_textfield.dart';
import 'package:chatsy/provider/home_provider.dart';
import 'package:chatsy/routes/route_directory.dart';
import 'package:chatsy/routes/route_names.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/custom_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeProvider>().getUsers(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Consumer<HomeProvider>(builder:
              (BuildContext context, HomeProvider value, Widget? child) {
            ImageProvider<Object>? imgProvider;
            if (value.data != null) {
              if (value.data?["image"] != null) {
                imgProvider = NetworkImage(value.data!["image"]);
              } else {
                imgProvider = const AssetImage('assets/images/profile.jpg');
              }
            }
            return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.profileRoute);
                },
                child: value.data != null
                    ? CircleAvatar(backgroundImage: imgProvider, radius: 30)
                    : const CircularProgressIndicator());
          }),
        ),
        title: Consumer<HomeProvider>(
            builder: (BuildContext context, HomeProvider value, Widget? child) {
          if (value.user == null) {
            return const Text('user');
          } else {
            return Text(value.user!);
          }
          // return Column(
          //   children: [
          //     Text((value.data["name"])??'user',style: Theme.of(context).textTheme.displayMedium),
          //     Text(value.data["description"]??'Iam using chatzy',style: Theme.of(context).textTheme.displaySmall,)
          //   ],
          //);
        }),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 260,
                      height: 50,
                      child: CustomTextField(
                        hint: 'Search..',
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {}, child: const Icon(Icons.add))),
                  )
                ],
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: CustomText(
                      text: 'Chatrooms',
                      style: Theme.of(context).textTheme.displayLarge)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 90,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.red, Colors.blue])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                              text: 'Rooms$index',
                              style: Theme.of(context).textTheme.displaySmall),
                          const SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 500,
                child: FutureBuilder<
                        List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                    future: context.read<HomeProvider>().getPeople(context),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteName.chatRoute,
                                      arguments: ScreenArguments(
                                          snapshot.data![index]["name"],
                                          snapshot.data![index]["image"],
                                          snapshot.data![index].id));
                                },
                                child: ListTile(
                                  title: CustomText(
                                      text: snapshot.data![index]["name"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                  subtitle: CustomText(
                                      text: 'last message',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                  trailing: Text('00:00pm',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        snapshot.data![index]["image"]),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
