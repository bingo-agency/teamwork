import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_work/AppState/providers/detailsProvider.dart';
import 'package:team_work/AppState/providers/featuredProvider.dart';
import 'package:team_work/AppState/providers/listingProvider.dart';
import 'package:team_work/AppState/providers/projectProvider.dart';
import 'package:team_work/AppState/providers/searchProvider.dart';
import 'package:team_work/models/database.dart';
import 'package:team_work/pages/detail/detail.dart';
// import 'package:team_work/notifier/responce_notifier.dart';
// import 'AppState.dart';
import 'routes/routes.dart';
// import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Get initial links
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  runApp(MyApp(initialLink: initialLink));
}

class MyApp extends StatefulWidget {
  final PendingDynamicLinkData? initialLink;
  MyApp({Key? key, this.initialLink}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    // final PendingDynamicLinkData? initialLink;
    initDynamicLinks();
    super.initState();
  }

  void initDynamicLinks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Future.delayed(Duration(seconds: 2));
    print('future is delayed.');
    print('and initial link from widget is : ' + widget.initialLink.toString());
    var data = await widget.initialLink;
    var deepLink = data?.link;
    print('printing deep link -> ');
    print(deepLink);
    final queryParams = deepLink!.queryParameters;
    if (queryParams.length > 0) {
      var post_id = queryParams['post_id'];
      print('post_id => ');
      print(post_id);
      if (post_id != null) {
        prefs.setString('post_id', post_id);
      } else {
        prefs.remove('post_id');
      }
    }
  }

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
        ChangeNotifierProvider.value(
          value: DetailsProvider(),
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
