import 'package:chatsy/custom_widgets/custom_textfield.dart';
import 'package:chatsy/provider/login_provider.dart';
import 'package:chatsy/provider/register_provider.dart';
import 'package:chatsy/routes/route_names.dart';
import 'package:chatsy/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final userController = TextEditingController();
  final capController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/images/img3.png')),
              Text(
                'Complete your profile',
                style: Constants.tstyle,
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<registerProvider>(builder: (BuildContext context,
                  registerProvider value, Widget? child) {
                ImageProvider<Object>? imgProvider;
                if (value.fileImage != null) {
                  imgProvider = FileImage(value.fileImage!);
                } else {
                  imgProvider = const AssetImage('assets/images/profile.jpg');
                }
                //var img= value.fileImage!=null? FileImage(value.fileImage!):AssetImage('assets/images/profile.jpg');
                return Stack(clipBehavior: Clip.none, children: [
                  CircleAvatar(
                    backgroundImage: imgProvider,
                    radius: 60,
                  ),
                  //    ClipOval(
                  //
                  // child:
                  // value.fileImage!=null? Image.file(value.fileImage!):Image.asset('assets/images/profile.jpg'),),
                  //  CircleAvatar(
                  //   backgroundImage:Image.file(File('')),
                  //   radius: 60,
                  // ),
                  Positioned(
                      bottom: -20,
                      right: 30,
                      child: ElevatedButton(
                        onPressed: () async {
                          await value.uploadImg(context);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.black),
                        child: value.isLoading == true
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Icon(Icons.add),
                      ))
                ]);
              }),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hint: 'enter a username',
                controller: userController,
                validator: (value) {
                  if (value == null) {
                    return 'Enter a username';
                  }
                  return null;
                },
                icon: const Icon(Icons.account_circle),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: 'enter a caption',
                controller: capController,
                validator: (value) {
                  if (value == null) {
                    return 'Enter a caption';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, RouteName.homeRoute);
                          context.read<LoginProvider>().setBool(true);
                        },
                        style: Constants.eStyle,
                        child: const Text('Skip'),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () async {
                          await context.read<registerProvider>().uploadData(
                              userController.text,
                              capController.text,
                              context.read<registerProvider>().url,
                              context);
                          await context.read<LoginProvider>().setBool(true);
                        },
                        style: Constants.eStyle,
                        child: const Text('Next'),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 500,
              )
            ],
          ),
        ),
      ),
    );
  }
}
