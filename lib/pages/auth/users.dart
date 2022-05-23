import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:team_work/pages/auth/profilepage.dart';
class users extends StatelessWidget {
  const users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
        padding: const EdgeInsets.all(10),
    child: ListView(children: <Widget>[
      Container(
        alignment: Alignment.center,
        child: CircleAvatar(radius: 150,
          child: SvgPicture.asset('assets/profile.svg')
        ),
      ),
      Container(
        alignment: Alignment.topLeft,
        child: Text('User Name'),
      ),
      SizedBox(
        height: 20,
      ),
      Container(
          height: 50,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          color: Colors.purple,

          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.purple
            ),
            child: const Text('Edit Profile'),
             onPressed: () => Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => const profilepage()),
             )


          )),
      Divider(),
      Container(
          height: 50,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          color: Colors.purple,

          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.purple
            ),
            child: const Text('Manage Ads'),
            onPressed: () {

            },
          )),
      Divider(),
      Container(
          height: 50,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          color: Colors.purple,

          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.purple
            ),
            child: const Text('Logout'),
            onPressed: () {

            },
          )),

    ],




    )
        )
    );
  }
}


