import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';

void searchBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
                leading: const Icon(AntIcons.searchOutlined),
                title: const TextField(
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    hintText: 'Internal ID code (digits only)',
                  ),
                ),
                onTap: () {
                  print('Internal ID Code.');
                }),
            const Divider(),
            ListTile(
                leading: const Icon(AntIcons.searchOutlined),
                title: const TextField(
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    hintText: 'Keyword',
                  ),
                ),
                onTap: () {
                  print('Keyword.');
                }),
            const Divider(),
            ListTile(
                leading: const Icon(AntIcons.searchOutlined),
                title: const TextField(
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    hintText: 'City',
                  ),
                ),
                onTap: () {
                  print('City');
                }),
            const Divider(),
            // ListTile(
            //   leading: const Icon(AntIcons.picCenterOutlined),
            //   title: const Text('City'),
            //   onTap: () {
            //     print('City');
            //   },
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Search'),
                ),
              ],
            ),
          ],
        );
      });
}
