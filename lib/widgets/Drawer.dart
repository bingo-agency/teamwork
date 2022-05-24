import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_work/pages/Career/contactus.dart';

import '../models/database.dart';
import '../pages/Property/Addproperty.dart';
import '../pages/home/home.dart';
import '../pages/listing/listing.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbclass = context.read<DataBase>();
    String id = '';

    Future getusername() async {
      String usr = await dbclass.getUsername();
      return usr;
    }

    Future getId() async {
      String _id = await dbclass.getId();
      id = _id;
      return id;
    }

    Future getimage() async {
      String img = await dbclass.getImage();
      return img;
    }

    getusername();
    getId();
    getimage();

    String curl = "?*";

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage('images/2.png'))),
              child: Stack(children: <Widget>[
                Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Text("TeamWork - ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700))),
              ])),
          ListTile(
            title: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Addproperty(id: id)));
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.add_location_alt,
                      color: Theme.of(context).primaryColor),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Add Property',
                      style: TextStyle(
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
            title: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.home_filled,
                      color: Theme.of(context).primaryColor),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Home',
                      style: TextStyle(
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
          ListTile(
            title: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListingPage(
                              curl: '',
                            )));
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.amp_stories_outlined,
                      color: Theme.of(context).primaryColor),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Listing',
                      style: TextStyle(
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
                      style: TextStyle(
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
                Icon(Icons.accessibility,
                    color: Theme.of(context).primaryColor),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Careers',
                    style: TextStyle(
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
          checkLogoutButton(id: id, dbclass: dbclass),
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
    print('printing id from checkloginbutton');
    print(id);
    if (id == '') {
      return Container();
    } else {
      return ListTile(
        title: Row(
          children: <Widget>[
            Icon(Icons.block, color: Theme.of(context).primaryColor),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Log Out',
                style: TextStyle(
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
