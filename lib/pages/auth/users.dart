import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/pages/auth/profilepage.dart';
import 'package:team_work/pages/home/home.dart';

import '../../models/database.dart';
import 'manageAds.dart';

class users extends StatelessWidget {
  const users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbclass = context.read<DataBase>();

    //here fetch the data from sharedPreferences only !!! otherwise take us to signup page !!!!
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Account",
          style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.background),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: const BackButton(
          color: Colors.white, // <-- SEE HERE
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: FutureBuilder(
                future: dbclass.getImage(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // print('your printed data is : ');
                    // print(snapshot.data);
                    return Container(
                      padding: const EdgeInsets.all(20.0),
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
                future: dbclass.getName(),
                initialData: const Text('Loading Name ... '),
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
            Container(
              alignment: Alignment.topLeft,
              child: FutureBuilder(
                future: dbclass.getEmail(),
                initialData: const Text('Loading Email ... '),
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
                color: Theme.of(context).primaryColor,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    child: Text(
                      'Edit Profile',
                      style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      // String id = await id;
                      // print("manage ads were tapped on id=" +
                      //     dbclass.id.toString());
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              profilepage(id: dbclass.id),
                        ),
                      );
                    })),
            const Divider(),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                color: Theme.of(context).primaryColor,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: Text(
                    'Manage Ads',
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    // print("manage ads were tapped on id =" +
                    //     dbclass.id.toString());
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ManageAds(id: dbclass.id),
                      ),
                    );
                  },
                )),
            const Divider(),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: Theme.of(context).primaryColor,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                child: Text(
                  'Logout',
                  style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  // dbclass.addAuth('', '');
                  dbclass.removeUser();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
