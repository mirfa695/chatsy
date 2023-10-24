import 'package:chatsy/provider/chat_provider.dart';
import 'package:chatsy/provider/home_provider.dart';
import 'package:chatsy/provider/login_provider.dart';
import 'package:chatsy/provider/register_provider.dart';
import 'package:chatsy/provider/theme_provider.dart';
import 'package:chatsy/routes/route_directory.dart';
import 'package:chatsy/routes/route_names.dart';
import 'package:chatsy/utilities/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
bool? _auth;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sPref=await SharedPreferences.getInstance();
  _auth=sPref.getBool('IsLoggedIn')??false;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginProvider>(create: (context)=>LoginProvider()),
    ChangeNotifierProvider<registerProvider>(create: (context)=>registerProvider()),
    ChangeNotifierProvider<HomeProvider>(create: (context)=>HomeProvider()),
    ChangeNotifierProvider<ThemeProvider>(create: (context)=>ThemeProvider()),
    ChangeNotifierProvider<ChatProvider>(create: (context)=>ChatProvider())
  ],
    child: const Main()));


}
class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(_auth);
    return Consumer<ThemeProvider>(
      builder: (BuildContext context, ThemeProvider value, Widget? child) {
      return MaterialApp(debugShowCheckedModeBanner: false,
       initialRoute:_auth==true?RouteName.homeRoute: RouteName.loginRoute,
        onGenerateRoute: RootDirectory.generateRoute,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: value.choice?ThemeMode.dark:ThemeMode.light,
      );}
    );
  }
}
