import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/database.dart';
import '../pages/listing/listing.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String curl = "?*";
    String newSetCity = '';
    TextEditingController textController = TextEditingController();
    String newval = textController.value.toString();

    var dbclass = context.read<DataBase>();
    String initialCity = dbclass.getCurrentCity().toString();

    // getCity() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   //Return String
    //   String stringValue = (prefs.getString('initial_city') ?? 'Islamabad');
    //   newSetCity = stringValue;
    //   return stringValue;
    // }

    return SizedBox(
      child: Stack(
        children: [
          Image.asset(
            'images/bkgrndapp.png',
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: TextField(
                textInputAction: TextInputAction.search,
                controller: textController,
                onSubmitted: (value) async {
                  newval = await value.toString();
                  print('go was hit !');
                  print(newval);
                  if (newval == '' || newSetCity == '') {
                    // curl = "?city=" + getCity().toString();
                    print(curl);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ListingPage(curl: curl),
                      ),
                    );
                  }
                  if (newval != '' && newSetCity != '') {
                    curl = "?keyword=" + newval + "&city_search=" + newSetCity;
                    print(curl);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ListingPage(curl: curl),
                      ),
                    );
                  }
                  if (newval == '') {
                    curl = "?city_search=" + newSetCity;
                    print(curl);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ListingPage(curl: curl),
                      ),
                    );
                  }
                  if (newSetCity == "") {
                    curl = "?keyword=" + newval;
                    print(curl);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ListingPage(curl: curl),
                      ),
                    );
                  }
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Search here ...',
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset('assets/icons/search.svg'),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      print('cities were tapped !!!');
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // Retrieve the text the that user has entered by using the
                            // TextEditingController.
                            content: SizedBox(
                              height: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    onTap: () {
                                      dbclass.setCity('Islamabad');
                                      print('Islamabad selected');
                                      Navigator.of(context).pop();
                                    },
                                    title: const Text('Islamabad'),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      dbclass.setCity('Lahore');
                                      Navigator.of(context).pop();
                                    },
                                    title: const Text('Lahore'),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      dbclass.setCity('Karachi');
                                      Navigator.of(context).pop();
                                    },
                                    title: const Text('Karachi'),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      dbclass.setCity('Peshawar');
                                      Navigator.of(context).pop();
                                    },
                                    title: const Text('Peshawar'),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      dbclass.setCity('Abbotabad');
                                      Navigator.of(context).pop();
                                    },
                                    title: const Text('Abbotabad'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child:
                          Consumer<DataBase>(builder: (context, value, child) {
                        return Text(
                          value.initial_city,
                          softWrap: true,
                          style: GoogleFonts.ubuntu(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        );
                        // }
                      }),
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(2),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
