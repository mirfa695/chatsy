import 'package:chatsy/custom_widgets/custom_textfield.dart';
import 'package:chatsy/provider/login_provider.dart';
import 'package:chatsy/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatelessWidget {
  OtpPage({Key? key}) : super(key: key);
  final otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginProvider = context.read<LoginProvider>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('assets/images/img4.png')),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'OTP',
              controller: otpController,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  onPressed: () async {
                    await loginProvider.signIn(otpController.text, context);
                  },
                  style: Constants.eStyle,
                  child: loginProvider.isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Verify'),
                ))
          ],
        ),
      ),
    );
  }
}
