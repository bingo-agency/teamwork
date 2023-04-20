import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_work/AppState/providers/detailsProvider.dart';
import 'package:team_work/AppState/providers/featuredProvider.dart';
import 'package:team_work/AppState/providers/listingProvider.dart';
import 'package:team_work/AppState/providers/homeListingProvider.dart';
import 'package:team_work/AppState/providers/projectProvider.dart';
import 'package:team_work/AppState/providers/searchProvider.dart';
import 'package:team_work/models/database.dart';
import 'routes/routes.dart';

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
  const MyApp({Key? key, this.initialLink}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // final PendingDynamicLinkData? initialLink;
    initDynamicLinks();
    super.initState();
  }

  void initDynamicLinks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = widget.initialLink;
    var deepLink = data?.link;

    if (deepLink != null) {
      Map<String, String> queryParams = deepLink.queryParameters;
      if (queryParams.isNotEmpty) {
        dynamic postId = queryParams['post_id'];
        if (postId != null) {
          prefs.setString('post_id', postId);
        } else {
          prefs.remove('post_id');
        }
      }
    }

    // Map<String, String> queryParams = deepLink!.queryParameters;
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
          value: HomeListingProvider(),
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
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.purple,
            ),
          ),
          useMaterial3: true,
          primaryColor: const Color(0xFF811B83),
          secondaryHeaderColor: const Color(0xFF100E34),
          // accentColor: const Color(0xFFFE9936),
          // accentColor: const Color(0xFF100E34),
          textTheme: TextTheme(
            displayLarge: const TextStyle(
              color: Color(0xFF100E34),
            ),
            bodyLarge: TextStyle(
              color: const Color(0xFF100E34).withOpacity(0.5),
            ),
          ),
          primaryTextTheme: GoogleFonts.ubuntuCondensedTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF811B83),
            primary: const Color(0xFF811B83), //<-- SEE HERE
          ).copyWith(background: const Color(0xFFF5F6F6)),
        ),
      ),
    );
  }
}
