import 'package:flutter/foundation.dart';

class ThemeProvider extends ChangeNotifier{
bool choice=false;
Future setTheme()async{
  choice=!choice;
  notifyListeners();
  return choice;
}
}