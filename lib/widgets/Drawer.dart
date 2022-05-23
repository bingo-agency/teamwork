import 'package:flutter/material.dart';

import '../pages/listing/listing.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            title: Row(
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
            onTap: () {},
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
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.where_to_vote,
                    color: Theme.of(context).primaryColor),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Featured',
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
          ListTile(
            title: Row(
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
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: Row(
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
          ListTile(
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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
