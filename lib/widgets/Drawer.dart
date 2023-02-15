import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/pages/Career/contactus.dart';

import '../models/database.dart';
import '../pages/Property/Addproperty.dart';
import '../pages/auth/login.dart';
import '../pages/home/home.dart';
import '../pages/listing/listing.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbclass = context.read<DataBase>();
    String curl = "?*";

    return Scaffold(
      body: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('images/2.png'))),
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: 1.0,
                    left: 1.0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_rounded),
                    )),
                Positioned(
                  bottom: 12.0,
                  left: 16.0,
                  child: Text(
                    "TeamWork ",
                    style: GoogleFonts.ubuntu(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.add_location_alt,
                    color: Theme.of(context).primaryColor),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Add Property',
                    style: GoogleFonts.ubuntu(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700),
                    softWrap: true,
                  ),
                )
              ],
            ),
            onTap: () {
              if (dbclass.id == "") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Addproperty(id: dbclass.id)));
              }
            },
          ),
          const Divider(),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.home_filled, color: Theme.of(context).primaryColor),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Home',
                    style: GoogleFonts.ubuntu(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700),
                    softWrap: true,
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.amp_stories_outlined,
                    color: Theme.of(context).primaryColor),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Listing',
                    style: GoogleFonts.ubuntu(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700),
                    softWrap: true,
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListingPage(
                    curl: '?*',
                  ),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Contact()));
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.call, color: Theme.of(context).primaryColor),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Contact',
                      style: GoogleFonts.ubuntu(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700),
                      softWrap: true,
                    ),
                  )
                ],
              ),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.add_business_outlined,
                    color: Theme.of(context).primaryColor),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'About',
                    style: GoogleFonts.ubuntu(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700),
                    softWrap: true,
                  ),
                )
              ],
            ),
            onTap: () {},
          ),
          const Divider(),
          checkLogoutButton(id: dbclass.id, dbclass: dbclass),
        ],
      ),
    );
  }
}

class checkLogoutButton extends StatelessWidget {
  String id;
  var dbclass;

  checkLogoutButton({Key? key, required this.id, this.dbclass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbclass = context.read<DataBase>();
    print('printing id from checkloginbutton');
    print(id);
    if (id == '') {
      return ListTile(
        title: Row(
          children: <Widget>[
            Icon(Icons.account_circle_rounded,
                color: Theme.of(context).primaryColor),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Login',
                style: GoogleFonts.ubuntu(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700),
                softWrap: true,
              ),
            )
          ],
        ),
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const Login()));
        },
      );
    } else {
      return ListTile(
        title: Row(
          children: <Widget>[
            Icon(Icons.block, color: Theme.of(context).primaryColor),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Log Out',
                style: GoogleFonts.ubuntu(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700),
                softWrap: true,
              ),
            )
          ],
        ),
        onTap: () {
          // dbclass.addAuth('', '');
          dbclass.removeUser();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        },
      );
    }

    return Container();
  }
}
