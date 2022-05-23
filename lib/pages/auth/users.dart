import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:team_work/pages/auth/profilepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_work/pages/home/home.dart';

import '../../models/database.dart';

class users extends StatelessWidget {
  const users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbclass = context.read<DataBase>();
    //here fetch the data from sharedPreferences only !!! otherwise take us to signup page !!!!
    return Scaffold(
        appBar: AppBar(
          title: const Text('Account'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                      radius: 150,
                      child: SvgPicture.asset('assets/profile.svg')),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(dbclass.username.toString()),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    color: Colors.purple,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.purple),
                        child: const Text('Edit Profile'),
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const profilepage()),
                            ))),
                Divider(),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    color: Colors.purple,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.purple),
                      child: const Text('Manage Ads'),
                      onPressed: () {},
                    )),
                const Divider(),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    color: Colors.purple,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.purple),
                      child: const Text('Logout'),
                      onPressed: () {
                        // dbclass.addAuth('', '');
                        dbclass.removeUser();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()));
                      },
                    )),
              ],
            )));
  }
}
