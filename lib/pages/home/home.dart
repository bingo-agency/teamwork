import 'dart:async';
import 'package:flutter/material.dart';
import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_work/pages/auth/login.dart';
import 'package:team_work/pages/detail/detail.dart';
import 'package:team_work/pages/home/widget/city.dart';
import 'package:team_work/pages/home/widget/projects.dart';
import 'package:team_work/widgets/Drawer.dart';
import 'package:team_work/widgets/best_offer.dart';
import 'package:team_work/widgets/propertyType.dart';
import 'package:team_work/widgets/featured.dart';
import 'package:flutter_svg/svg.dart';
import 'package:team_work/widgets/welcome_text.dart';
import '../../models/database.dart';
import '../Notifications/notifications.dart';
import '../Property/addNewProperty.dart';
import '../auth/manageAds.dart';
import '../auth/profilepage.dart';
import '../listing/listing.dart';

// import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({Key? key}) : super(key: key);
  ScrollController scrollController = ScrollController();
  double indicator = 10.0;
  bool onTop = true;

  @override
  Widget build(BuildContext context) {
    String? postId;
    void getPostId() async {
      // print('getting post id ');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      postId = prefs.getString('post_id');

      // print('post_id at home : ');
      // print(post_id);
      // print('orinting final post id ' + post_id.toString());
      Timer(const Duration(seconds: 1), () {
        if (postId != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailPage(id: postId),
            ),
          );
        } else {
          // print('its null so stay here !');
        }
        prefs.remove('post_id');
      });
    }

    getPostId();

    var dbclass = context.read<DataBase>();
    dbclass.getCity();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 2,
          title: const Image(
            image: AssetImage('assets/images/teamWrkLogo.png'),
            width: 150,
          ),
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/menu.svg',
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          actions: [
            (dbclass.id == "")
                ? InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Notifications(id: dbclass.id)));
                    },
                    child: Icon(
                      Icons.notifications,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : Container(),
            const SizedBox(
              width: 2.0,
            ),
            FutureBuilder(
              future: dbclass.getEmail(),
              initialData: const Center(
                child: CircularProgressIndicator(),
              ),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return GestureDetector(
                  onTap: () async {
                    if (dbclass.id == "") {
                      // print(dbclass.email);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => const Login()));
                    } else {
                      // print(dbclass.email);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              profilepage(id: dbclass.id)));
                    }
                  },
                  child: Icon(
                    Icons.account_circle_rounded,
                    size: 35,
                    color: Theme.of(context).primaryColor,
                  ),
                );
              },
            )
          ],
        ),
        drawer: const Mydrawer(),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: const [
              WelcomeText(),
              PropertyType(),
              Featured(),
              Listing(),
              City(),
              Projects()
            ],
          ),
        ),
        floatingActionButton: ScrollingFabAnimated(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          text: Text(
            'Add ',
            style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 16.0),
          ),
          onPress: () async {
            if (dbclass.id == "") {
              // print(dbclass.getEmail());
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const Login(),
                ),
              );
            } else {
              // print(dbclass.email);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AddNewProperty(id: dbclass.id),
                ),
              );
            }
          },
          scrollController: scrollController,
          animateIcon: true,
          // limitIndicator: 1.0,
          curve: Curves.easeInOut,
          inverted: false,
          radius: 10.0,
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        // floatingActionButton: Stack(
        //   children: [
        //     Positioned(
        //       left: MediaQuery.of(context).size.width / 2.1,
        //       bottom: 23,
        //       child: Container(
        //         decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             // border: Border.all(color: Colors.white, width: 5),
        //             color: Theme.of(context).primaryColor),
        //         child: FloatingActionButton(
        //           onPressed: () async {
        //             if (dbclass.id == "") {
        //               // print(dbclass.getEmail());
        //               Navigator.of(context).push(
        //                 MaterialPageRoute(
        //                   builder: (BuildContext context) => const Login(),
        //                 ),
        //               );
        //             } else {
        //               // print(dbclass.email);
        //               Navigator.of(context).push(
        //                 MaterialPageRoute(
        //                   builder: (BuildContext context) =>
        //                       AddNewProperty(id: dbclass.id),
        //                 ),
        //               );
        //             }
        //           },
        //           elevation: 10,
        //           backgroundColor: Theme.of(context).primaryColor,
        //           child: const Icon(Icons.add, color: Colors.white),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

        bottomNavigationBar: BottomNavigationBar(
          onTap: (int i) {
            if (i == 1) {
              // print('Listing');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListingPage(
                    curl: '?*',
                  ),
                ),
              );
            }
            if (i == 2) {
              // print('ads');
              if (dbclass.id == "") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
                // Navigator.pushNamed(context, '/login');
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManageAds(id: dbclass.id),
                  ),
                );
              }
            }
            if (i == 3) {
              // print('settings');
              if (dbclass.id == "") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => profilepage(id: dbclass.id)));
              }
            }
          },
          backgroundColor: Theme.of(context).colorScheme.background,
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(AntIcons.homeOutlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(AntIcons.unorderedListOutlined),
              label: 'Listings',
            ),
            BottomNavigationBarItem(
              icon: Icon(AntIcons.apartmentOutlined),
              label: 'My Ads',
            ),
            BottomNavigationBarItem(
              icon: Icon(AntIcons.settingOutlined),
              label: 'Settings',
            ),
            // Mybottom(),
          ],
          selectedLabelStyle:
              GoogleFonts.ubuntu(fontWeight: FontWeight.w800, fontSize: 14.0),
          unselectedLabelStyle:
              GoogleFonts.ubuntu(fontWeight: FontWeight.w600, fontSize: 14.0),
        )
        // Mybottom(),
        );
  }
}
