import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/pages/Career/contactus.dart';

import '../models/database.dart';
import '../pages/Property/Addproperty.dart';
import '../pages/auth/login.dart';
import '../pages/listing/listing.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbclass = context.read<DataBase>();
    String curl = "?*";

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.white70, BlendMode.softLight),
                image: AssetImage('assets/images/offer02.jpeg'),
              ),
            ),
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
                  child: Center(
                    child: Image(
                      width: MediaQuery.of(context).size.width / 2,
                      image: const AssetImage(
                        "assets/images/teamWrkLogo.png",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(AntIcons.usergroupAddOutlined,
                    color: Theme.of(context).primaryColor),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Add Property',
                    style: GoogleFonts.ubuntu(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0),
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
                Icon(AntIcons.homeOutlined,
                    color: Theme.of(context).primaryColor),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Home',
                    style: GoogleFonts.ubuntu(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0),
                    softWrap: true,
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(AntIcons.unorderedListOutlined,
                    color: Theme.of(context).primaryColor),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Listing',
                    style: GoogleFonts.ubuntu(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0),
                    softWrap: true,
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListingPage(
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
                  Icon(AntIcons.phoneOutlined,
                      color: Theme.of(context).primaryColor),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Contact',
                      style: GoogleFonts.ubuntu(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0),
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
                Icon(AntIcons.bulbOutlined,
                    color: Theme.of(context).primaryColor),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'About',
                    style: GoogleFonts.ubuntu(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0),
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
            Icon(AntIcons.userAddOutlined,
                color: Theme.of(context).primaryColor),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Login',
                style: GoogleFonts.ubuntu(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0),
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
      return Container(
        margin: const EdgeInsets.only(top: 10.0, bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                const SizedBox(
                  child: Icon(AntIcons.logoutOutlined,
                      size: 40.0, color: Colors.redAccent),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Logout',
                        style: GoogleFonts.ubuntu(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                      const Icon(
                        AntIcons.rightOutlined,
                        color: Colors.redAccent,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
      // return ListTile(
      //   title: Row(
      //     children: <Widget>[
      //       Icon(AntIcons.userDeleteOutlined,
      //           color: Theme.of(context).primaryColor),
      //       Padding(
      //         padding: const EdgeInsets.only(left: 8.0),
      //         child: Text(
      //           'Log Out',
      //           style: GoogleFonts.ubuntu(
      //               color: Theme.of(context).primaryColor,
      //               fontWeight: FontWeight.w700,
      //               fontSize: 18.0),
      //           softWrap: true,
      //         ),
      //       )
      //     ],
      //   ),
      //   onTap: () {
      //     // dbclass.addAuth('', '');
      //     dbclass.removeUser();
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (BuildContext context) => HomePage(),
      //       ),
      //     );
      //   },
      // );
    }
    // return Container();
  }
}
