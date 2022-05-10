import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/notifier/responce_notifier.dart';


import 'AppState.dart';
import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context)=>responcenotifier(),
          builder: (context,child){
            return Container();
          },
        ),
    ChangeNotifierProvider(
      create: (context) => AppState(),
builder: (context,child) {
  return MaterialApp(
    title: 'Team Work Property Exchange',
    initialRoute: RouteManager.home,
    onGenerateRoute: RouteManager.generateRoute,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      backgroundColor: Color(0xFFF5F6F6),
      primaryColor: Color(0xFF811B83),
      secondaryHeaderColor: Color(0xFFFE9936),
      accentColor: Color(0xFFFE9936),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Color(0xFF100E34),
        ),
        bodyText1: TextStyle(
          color: Color(0xFF100E34).withOpacity(0.5),
        ),
      ),
    ),
  );
}),
      ],







    );
  }
}
