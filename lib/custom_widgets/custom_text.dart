import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  CustomText({
    this.text,
    this.size,
    this.style,
    Key? key,
  }) : super(key: key);
  String? text;
  double? size;
  TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Text(text ?? '', style: style);
  }
}
