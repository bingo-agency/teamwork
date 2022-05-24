import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:team_work/pages/auth/profilepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_work/pages/home/home.dart';

import '../../models/database.dart';
import 'manageAds.dart';

class users extends StatelessWidget {
  const users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbclass = context.read<DataBase>();

    Future getusername() async {
      String usr = await dbclass.getUsername();
      return usr;
    }

    Future getId() async {
      String id = await dbclass.getId();
      return id;
    }

    Future getimage() async {
      String img = await dbclass.getImage();
      return img;
    }

    getusername();
    getId();
    getimage();

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
                  child: FutureBuilder(
                    future: getimage(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        print('your printed data is : ');
                        print(snapshot.data);
                        return Container(
                          padding: EdgeInsets.all(20.0),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data,
                            fit: BoxFit.contain,
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: FutureBuilder(
                    future: getusername(),
                    initialData: const CircularProgressIndicator(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      print(snapshot.data.toString() + 'is your data ');
                      if (snapshot.hasData) {
                        return Center(child: Text(snapshot.data.toString()));
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: FutureBuilder(
                    future: getusername(),
                    initialData: const CircularProgressIndicator(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      // print(snapshot.data.toString() + 'is your data ');
                      if (snapshot.hasData) {
                        return Center(child: Text(snapshot.data.toString()));
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
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
                const Divider(),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    color: Colors.purple,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.purple),
                      child: Text('Manage Ads'),
                      onPressed: () async {
                        String id = await getId();
                        print("manage ads were tapped ");
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ManageAds(id: id),
                          ),
                        );
                      },
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
