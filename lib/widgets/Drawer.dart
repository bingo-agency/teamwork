import 'package:flutter/material.dart';
class Mydrawer extends StatelessWidget {
  const Mydrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(child: ListView(
      children: [
        ListTile(title: Text('Home'),
        ),
        Divider(),

        ListTile(title:  Text('Listings'),
        ),
        Divider(),
        ListTile(title:  Text('Projects'),
        ),
        Divider(),
        ListTile(title:  Text('Careers'),
        ),
        Divider(),

      ],
    ),

    );
  }
}

