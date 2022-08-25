import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/pages/Property/Addproperty.dart';
import 'package:team_work/pages/auth/login.dart';
import 'package:team_work/pages/home/widget/city.dart';
import 'package:team_work/pages/home/widget/projects.dart';
import 'package:team_work/widgets/Drawer.dart';
import 'package:team_work/widgets/best_offer.dart';
import 'package:team_work/widgets/propertyType.dart';
import 'package:team_work/widgets/recommended_house.dart';
import 'package:flutter_svg/svg.dart';
import 'package:team_work/widgets/welcome_text.dart';
import '../../models/database.dart';
import '../auth/manageAds.dart';
import '../auth/profilepage.dart';
import '../auth/users.dart';
import '../listing/listing.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbclass = context.read<DataBase>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Image(
            image: AssetImage('images/teamWrkNew.png'),
            width: 120,
          ),
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/menu.svg',
              color: Colors.purple,
            ),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          actions: [
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
                          builder: (BuildContext context) => const users()));
                    }
                  },
                  child: const Icon(
                    Icons.account_circle_rounded,
                    size: 40,
                    color: Colors.purple,
                  ),
                );
              },
            )
          ],
        ),
        drawer: const Mydrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              WelcomeText(),
              PropertyType(),
              RecommendedHouse(),
              Listing(),
              City(),
              Projects()
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Stack(
          children: [
            Positioned(
              left: MediaQuery.of(context).size.width / 2.1,
              bottom: 23,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 5),
                    color: Colors.purple),
                child: FloatingActionButton(
                  onPressed: () async {
                    if (dbclass.id == "") {
                      // print(dbclass.getEmail());
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => const Login()));
                    } else {
                      // print(dbclass.email);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Addproperty(id: dbclass.id)));
                    }
                  },
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (int i) {
              if (i == 1) {
                print('Listing');
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
                print('ads');
                if (dbclass.id == "") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ManageAds(id: dbclass.id)));
                }
              }
              if (i == 3) {
                print('settings');
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
            backgroundColor: Colors.white,
            currentIndex: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.amp_stories_outlined),
                label: 'Listings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.house_outlined),
                label: 'Ads',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
              // Mybottom(),
            ])
        // Mybottom(),
        );
  }
}
