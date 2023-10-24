import 'package:flutter/material.dart';

class Constants {
  static Color bgColor = const Color(0xff292F3F);
  static TextStyle tstyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
      letterSpacing: 1);
  static ButtonStyle eStyle =
      ElevatedButton.styleFrom(backgroundColor: Colors.black.withOpacity(.6));
  static String defaultImage =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbTLY9TJ6snn0WUxdmwUTCj8XavL3Q3kpXuHkMrp6NNqmfRCFh-9SDxo-gb7sfABdmImo&usqp=CAU';
}
