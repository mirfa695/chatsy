import 'package:chatsy/routes/route_names.dart';
import 'package:chatsy/screens/chat_page.dart';
import 'package:chatsy/screens/default_page.dart';
import 'package:chatsy/screens/home_page.dart';
import 'package:chatsy/screens/login_page.dart';
import 'package:chatsy/screens/otp_page.dart';
import 'package:chatsy/screens/profile_page.dart';
import 'package:chatsy/screens/register_page.dart';
import 'package:flutter/material.dart';

class RootDirectory{
  static Route generateRoute(RouteSettings settings){
    var args=settings.arguments;
    switch(settings.name){
      case RouteName.loginRoute:return MaterialPageRoute(builder: (context)=>LoginPage());
      case RouteName.registerRoute:return MaterialPageRoute(builder: (context)=>RegisterPage());
      case RouteName.otpRoute:return MaterialPageRoute(builder: (context)=>OtpPage());
      case RouteName.homeRoute:return MaterialPageRoute(builder: (context)=>const HomePage());
      case RouteName.profileRoute:return MaterialPageRoute(builder: (context)=>const ProfilePage());

      case RouteName.chatRoute:return MaterialPageRoute(builder: (context){
        ScreenArguments arguments=args as ScreenArguments;
          return ChatPage(name: arguments.name,image: arguments.image,id:arguments.id);});
      default:return MaterialPageRoute(builder: (context)=>const DefaultPage());
    }
  }
}
class ScreenArguments{
  final String name;
  final String image;
  final String id;
  ScreenArguments(this.name,this.image,this.id);
}