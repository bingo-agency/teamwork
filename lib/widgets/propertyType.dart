import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_work/pages/listing/listing.dart';
import 'package:team_work/widgets/best_offer.dart';

class PropertyType extends StatelessWidget {
  const PropertyType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String curl = "?*";
    return Container(
      height: 80,
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          GestureDetector(
            onTap: () {
              curl = "?property_type=vehicle";
              print(curl);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ListingPage(curl: curl)));
            },
            child: Card(
              elevation: 3.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                          image: AssetImage('assets/icons/car.png'), width: 30),
                    ),
                    Text(
                      'Vehicle',
                      style: GoogleFonts.ubuntu(
                        color: Colors.purple,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              curl = "?property_type=land";
              print(curl);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ListingPage(curl: curl)));
            },
            child: Card(
              elevation: 3.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/icons/land.svg',
                        width: 30,
                      ),
                    ),
                    Text(
                      'Land',
                      style: GoogleFonts.ubuntu(
                        color: Colors.purple,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              curl = "?property_type=plot";
              print(curl);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ListingPage(curl: curl)));
            },
            child: Card(
              elevation: 3.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/icons/plot.svg',
                        width: 30,
                      ),
                    ),
                    Text(
                      'Plot',
                      style: GoogleFonts.ubuntu(
                        color: Colors.purple,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              curl = "?property_type=office";
              print(curl);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ListingPage(curl: curl)));
            },
            child: Card(
              elevation: 3.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/icons/shape24.svg',
                        width: 30,
                      ),
                    ),
                    Text(
                      'Offices',
                      style: GoogleFonts.ubuntu(
                        color: Colors.purple,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     curl = "?property_type=restaurant";
          //     print(curl);
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) => ListingPage(curl: curl)));
          //   },
          //   child: Card(
          //     elevation: 3.0,
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: SvgPicture.asset(
          //               'assets/icons/shape25.svg',
          //               width: 30,
          //             ),
          //           ),
          //           Text(
          //             'Restaurant',
          //             style: GoogleFonts.ubuntu(
          //               color: Colors.purple,
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              curl = "?property_type=studio";
              print(curl);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ListingPage(curl: curl)));
            },
            child: Card(
              elevation: 3.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/icons/shape26.svg',
                        width: 30,
                      ),
                    ),
                    Text(
                      'Studio Home',
                      style: GoogleFonts.ubuntu(
                        color: Colors.purple,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              curl = "?property_type=apartments";
              print(curl);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ListingPage(curl: curl)));
            },
            child: Card(
              elevation: 3.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/icons/shape22.svg',
                        width: 30,
                      ),
                    ),
                    Text(
                      'Apartments',
                      style: GoogleFonts.ubuntu(
                        color: Colors.purple,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
