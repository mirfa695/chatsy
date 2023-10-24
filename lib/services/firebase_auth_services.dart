import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  late String _verification;
  Future phNoAuth(
    String phno,
  ) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phno,
        verificationCompleted: (AuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException exeption) {
        },
        codeSent: (String verificationId, int? resendToken) {
          _verification = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verification = verificationId;
        });
  }

  Future<void> signIn(String otp) async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: _verification,
      smsCode: otp,
    ));
  }
}
