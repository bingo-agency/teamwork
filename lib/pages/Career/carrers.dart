import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/database.dart';

class careers extends StatelessWidget {
  const careers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.read<DataBase>().fetchcareers;
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 100,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            'Job Opening',
            style: GoogleFonts.montserrat(
                color: Theme.of(context).primaryColor, fontSize: 30),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            'Recent job opening',
            style: GoogleFonts.montserrat(color: Colors.black, fontSize: 30),
          ),
        ),
        Container(),
        //   Container(
        //   padding: const EdgeInsets.all(15),
        //   height: 350,
        //   child: RefreshIndicator(
        //     onRefresh: () async {},
        //     child: Consumer<DataBase>(
        //       builder: (context, value, child) {
        //         return value.mapcareers.isEmpty && !value.errorcareers
        //             ? const Center(child: CircularProgressIndicator())
        //             : value.errorcareers
        //             ? Text(
        //           'Oops, something went wrong .${value.errorMessagecareers}',
        //           textAlign: TextAlign.center,
        //         )
        //             : ListView.builder(
        //           shrinkWrap: true,
        //           scrollDirection: Axis.vertical,
        //           itemCount: value.mapcareers['careers'].length,
        //           itemBuilder: (context, index) {
        //             return MyTempCard(
        //                 map: value.mapcareers['careers'][index]);
        //           },
        //         );
        //       },
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}

class MyTempCard extends StatelessWidget {
  const MyTempCard({Key? key, required this.map}) : super(key: key);
  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Stack(
          fit: StackFit.loose,
          children: [
            Image.network(
                'https://www.smartsimple.com/hubfs/Imported_Blog_Media/1_1R8xfVJxpCrAL6Cbml4WEQ.jpg'),
            Positioned(
                top: 90,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(map['title'],
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(map['available_seats'],
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.ubuntu(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ]))
          ],
        ));
  }
}
