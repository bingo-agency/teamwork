import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/AppState/providers/featuredProvider.dart';
import 'package:team_work/AppState/providers/listingProvider.dart';
import 'package:team_work/AppState/providers/projectProvider.dart';
import 'package:team_work/AppState/providers/searchProvider.dart';
import 'package:team_work/models/database.dart';
import 'package:team_work/notifier/responce_notifier.dart';

import 'AppState.dart';
import 'routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';

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
        ChangeNotifierProvider.value(
          value: DataBase(),
        ),
        ChangeNotifierProvider.value(
          value: FeaturedProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ListingProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ProjectProvider(),
        ),
        ChangeNotifierProvider.value(
          value: SearchProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Team Work Property Exchange',
        initialRoute: RouteManager.splashPage,
        onGenerateRoute: RouteManager.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF811B83),
            primary: const Color(0xFF811B83), //<-- SEE HERE
          ),
          backgroundColor: const Color(0xFFF5F6F6),
          primaryColor: const Color(0xFF811B83),
          secondaryHeaderColor: const Color(0xFF100E34),
          // accentColor: const Color(0xFFFE9936),
          accentColor: const Color(0xFF100E34),
          textTheme: TextTheme(
            headline1: const TextStyle(
              color: Color(0xFF100E34),
            ),
            bodyText1: TextStyle(
              color: const Color(0xFF100E34).withOpacity(0.5),
            ),
          ),
          primaryTextTheme: GoogleFonts.ubuntuCondensedTextTheme(),
        ),
      ),
    );
  }
}
