import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.hint,
      this.icon,
      this.eye,
      this.obsecure,
      this.controller,
      this.validator,
      Key? key})
      : super(key: key);
  String? hint;
  Widget? icon;
  Widget? eye;
  TextEditingController? controller;
  String? Function(String?)? validator;
  bool? obsecure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure ?? false,
      controller: controller,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint ?? '',
        prefixIcon: icon,
        suffixIcon: eye,
      ),
    );
  }
}
