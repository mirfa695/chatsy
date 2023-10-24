import 'package:chatsy/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../provider/login_provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  late var phNoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  late PhoneNumber number1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Image(image: AssetImage('assets/images/img1.png')),
                const SizedBox(
                  height: 80,
                ),
                Text(
                  'LOGIN',
                  style: Constants.tstyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                InternationalPhoneNumberInput(
                    textFieldController: phNoController,
                    selectorTextStyle: const TextStyle(color: Colors.grey),
                    textStyle: Theme.of(context).textTheme.displayMedium,
                    validator: (value) {
                      if (value == null) {
                        return 'Enter a valid phone number';
                      }
                    },
                    initialValue: number,
                    onInputChanged: (PhoneNumber number2) {
                      number1 = number2;
                    }),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await context
                              .read<LoginProvider>()
                              .phnoLogin(number1.phoneNumber!, context);
                        }
                      },
                      style: Constants.eStyle,
                      child: context.watch<LoginProvider>().isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text('Login'),
                    )),
                const SizedBox(
                  height: 300,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
