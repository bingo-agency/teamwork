import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:team_work/widgets/searchBottomSheet.dart';
import 'package:team_work/widgets/user_api.dart';
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
    final TextEditingController typeAheadController2 = TextEditingController();

    var dbclass = context.read<DataBase>();

    // String initialCity = dbclass.getCurrentCity().toString();

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
              child: Card(
                elevation: 3.0,
                child: GestureDetector(
                  onTap: () async {
                    print('cool');
                    searchBottomSheet(context);
                  },
                  child: ListTile(
                    leading: Icon(AntIcons.searchOutlined,
                        color: Theme.of(context).primaryColor),
                    title: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          'Search here ... ',
                          textStyle: GoogleFonts.ubuntu(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        TyperAnimatedText(
                          'Vehicles ...',
                          textStyle: GoogleFonts.ubuntu(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        TyperAnimatedText(
                          'Plots ...',
                          textStyle: GoogleFonts.ubuntu(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        TyperAnimatedText(
                          'Offices ...',
                          textStyle: GoogleFonts.ubuntu(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        TyperAnimatedText(
                          'Flats ...',
                          textStyle: GoogleFonts.ubuntu(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        TyperAnimatedText(
                          'Apartments ...',
                          textStyle: GoogleFonts.ubuntu(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        TyperAnimatedText(
                          'Shops ...',
                          textStyle: GoogleFonts.ubuntu(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        TyperAnimatedText(
                          'Internal ID # ',
                          textStyle: GoogleFonts.ubuntu(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        TyperAnimatedText(
                          'Search here ... ',
                          textStyle: GoogleFonts.ubuntu(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        )
                      ],
                      // child: Text(
                      //   'Search here ...',
                      //   style: GoogleFonts.ubuntu(fontSize: 16.0),
                      // ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        // print('cities were tapped !!!');
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Select City',
                                style: GoogleFonts.ubuntu(
                                    color: Theme.of(context).primaryColor),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    ListTile(
                                      title: Text('Get City From Gps',
                                          style: GoogleFonts.ubuntu()),
                                      leading: Icon(
                                        Icons.gps_fixed_outlined,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onTap: () async {
                                        await dbclass.getPermission();
                                        dbclass.getCurrentlocation();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: TypeAheadFormField<City?>(
                                        hideSuggestionsOnKeyboardHide: false,
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                          focusNode: FocusScopeNode(),
                                          enableSuggestions: false,
                                          autofocus: false,
                                          controller: typeAheadController2,
                                          decoration: InputDecoration(
                                            hintStyle: GoogleFonts.montserrat(),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black12)),
                                            focusedBorder: InputBorder.none,
                                            hintText: 'Search City ...',
                                          ),
                                        ),
                                        suggestionsCallback:
                                            UserApi1.getCitySuggestions,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please Enter City Name';
                                          }
                                          return null;
                                        },
                                        itemBuilder:
                                            (context, City? suggestion) {
                                          final city = suggestion!;

                                          return ListTile(
                                            title: Text(city.name),
                                          );
                                        },
                                        noItemsFoundBuilder: (context) =>
                                            const SizedBox(
                                          height: 10,
                                          child: Center(
                                            child: Text(
                                              'No City Found.',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        onSuggestionSelected:
                                            (City? suggestion) {
                                          final city = suggestion!;

                                          typeAheadController2.text =
                                              city.name.toString();
                                          // print(city.name.toString());
                                          dbclass.setCity(city.name.toString());
                                          // dbclass.initial_city = city.name;
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );

                            // return AlertDialog(
                            //   // Retrieve the text the that user has entered by using the
                            //   // TextEditingController.
                            //   content: SizedBox(
                            //     height: 300,
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         ListTile(
                            //           onTap: () {
                            //             dbclass.setCity('Islamabad');
                            //             print('Islamabad selected');
                            //             Navigator.of(context).pop();
                            //           },
                            //           title: const Text('Islamabad'),
                            //         ),
                            //         ListTile(
                            //           onTap: () {
                            //             dbclass.setCity('Lahore');
                            //             Navigator.of(context).pop();
                            //           },
                            //           title: const Text('Lahore'),
                            //         ),
                            //         ListTile(
                            //           onTap: () {
                            //             dbclass.setCity('Karachi');
                            //             Navigator.of(context).pop();
                            //           },
                            //           title: const Text('Karachi'),
                            //         ),
                            //         ListTile(
                            //           onTap: () {
                            //             dbclass.setCity('Peshawar');
                            //             Navigator.of(context).pop();
                            //           },
                            //           title: const Text('Peshawar'),
                            //         ),
                            //         ListTile(
                            //           onTap: () {
                            //             dbclass.setCity('Abbotabad');
                            //             Navigator.of(context).pop();
                            //           },
                            //           title: const Text('Abbotabad'),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Consumer<DataBase>(
                            builder: (context, value, child) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(AntIcons.environmentOutlined,
                                  color: Theme.of(context).primaryColor),
                              Text(
                                " " + value.initial_city,
                                softWrap: true,
                                style: GoogleFonts.ubuntu(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15.0),
                              ),
                            ],
                          );
                          // }
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // child: TextField(
          //   textInputAction: TextInputAction.search,
          //   controller: textController,
          //   onSubmitted: (value) async {
          //     newval = value.toString();
          //     // print('go was hit !');
          //     // print(newval);
          //     if (newval == '' || newSetCity == '') {
          //       // curl = "?city=" + getCity().toString();
          //       // print(curl);
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (BuildContext context) =>
          //               ListingPage(curl: curl),
          //         ),
          //       );
          //     }
          //     if (newval != '' && newSetCity != '') {
          //       curl = "?keyword=$newval&city_search=$newSetCity";
          //       // print(curl);
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (BuildContext context) =>
          //               ListingPage(curl: curl),
          //         ),
          //       );
          //     }
          //     if (newval == '') {
          //       curl = "?city_search=$newSetCity";
          //       // print(curl);
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (BuildContext context) =>
          //               ListingPage(curl: curl),
          //         ),
          //       );
          //     }
          //     if (newSetCity == "") {
          //       curl = "?keyword=$newval";
          //       // print(curl);
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (BuildContext context) =>
          //               ListingPage(curl: curl),
          //         ),
          //       );
          //     }
          //   },
          //   decoration: InputDecoration(
          //     fillColor: Colors.white,
          //     filled: true,
          //     border: OutlineInputBorder(
          //       borderSide: BorderSide.none,
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     hintText: 'Search here ...',
          //     prefixIcon: Container(
          //       padding: const EdgeInsets.all(15),
          //       child: SvgPicture.asset('assets/icons/search.svg'),
          //     ),
          //     suffixIcon: GestureDetector(
          //       onTap: () {
          //         // print('cities were tapped !!!');
          //         showDialog(
          //           context: context,
          //           builder: (context) {
          //             return AlertDialog(
          //                 title: const Text('Select City'),
          //                 content: SingleChildScrollView(
          //                   child: ListBody(
          //                     children: [
          //                       ListTile(
          //                         title: const Text('Get City From Gps'),
          //                         trailing: const Icon(
          //                           Icons.gps_fixed,
          //                           color: Colors.blue,
          //                         ),
          //                         onTap: () async {
          //                           await dbclass.getPermission();
          //                           dbclass.getCurrentlocation();
          //                           Navigator.of(context).pop();
          //                         },
          //                       ),
          //                       Container(
          //                         padding: const EdgeInsets.all(10),
          //                         child: TypeAheadFormField<City?>(
          //                           hideSuggestionsOnKeyboardHide: false,
          //                           textFieldConfiguration:
          //                               TextFieldConfiguration(
          //                             focusNode: FocusScopeNode(),
          //                             enableSuggestions: false,
          //                             autofocus: false,
          //                             controller: typeAheadController2,
          //                             decoration: InputDecoration(
          //                               hintStyle: GoogleFonts.montserrat(),
          //                               border: const OutlineInputBorder(
          //                                   borderSide: BorderSide(
          //                                       color: Colors.black12)),
          //                               focusedBorder: InputBorder.none,
          //                               hintText: 'Search City ...',
          //                             ),
          //                           ),
          //                           suggestionsCallback:
          //                               UserApi1.getCitySuggestions,
          //                           validator: (value) {
          //                             if (value == null || value.isEmpty) {
          //                               return 'Please Enter City Name';
          //                             }
          //                             return null;
          //                           },
          //                           itemBuilder:
          //                               (context, City? suggestion) {
          //                             final city = suggestion!;

          //                             return ListTile(
          //                               title: Text(city.name),
          //                             );
          //                           },
          //                           noItemsFoundBuilder: (context) =>
          //                               const SizedBox(
          //                             height: 10,
          //                             child: Center(
          //                               child: Text(
          //                                 'No City Found.',
          //                                 style: TextStyle(fontSize: 16),
          //                               ),
          //                             ),
          //                           ),
          //                           onSuggestionSelected:
          //                               (City? suggestion) {
          //                             final city = suggestion!;

          //                             typeAheadController2.text =
          //                                 city.name.toString();
          //                             // print(city.name.toString());
          //                             dbclass.setCity(city.name.toString());
          //                             // dbclass.initial_city = city.name;
          //                             Navigator.pop(context);
          //                           },
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ));

          //             // return AlertDialog(
          //             //   // Retrieve the text the that user has entered by using the
          //             //   // TextEditingController.
          //             //   content: SizedBox(
          //             //     height: 300,
          //             //     child: Column(
          //             //       mainAxisAlignment: MainAxisAlignment.start,
          //             //       crossAxisAlignment: CrossAxisAlignment.start,
          //             //       children: [
          //             //         ListTile(
          //             //           onTap: () {
          //             //             dbclass.setCity('Islamabad');
          //             //             print('Islamabad selected');
          //             //             Navigator.of(context).pop();
          //             //           },
          //             //           title: const Text('Islamabad'),
          //             //         ),
          //             //         ListTile(
          //             //           onTap: () {
          //             //             dbclass.setCity('Lahore');
          //             //             Navigator.of(context).pop();
          //             //           },
          //             //           title: const Text('Lahore'),
          //             //         ),
          //             //         ListTile(
          //             //           onTap: () {
          //             //             dbclass.setCity('Karachi');
          //             //             Navigator.of(context).pop();
          //             //           },
          //             //           title: const Text('Karachi'),
          //             //         ),
          //             //         ListTile(
          //             //           onTap: () {
          //             //             dbclass.setCity('Peshawar');
          //             //             Navigator.of(context).pop();
          //             //           },
          //             //           title: const Text('Peshawar'),
          //             //         ),
          //             //         ListTile(
          //             //           onTap: () {
          //             //             dbclass.setCity('Abbotabad');
          //             //             Navigator.of(context).pop();
          //             //           },
          //             //           title: const Text('Abbotabad'),
          //             //         ),
          //             //       ],
          //             //     ),
          //             //   ),
          //             // );
          //           },
          //         );
          //       },
          //       child: Container(
          //         padding: const EdgeInsets.all(15),
          //         child:
          //             Consumer<DataBase>(builder: (context, value, child) {
          //           return Text(
          //             value.initial_city,
          //             softWrap: true,
          //             style: GoogleFonts.ubuntu(
          //                 color: Theme.of(context).primaryColor,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 16.0),
          //           );
          //           // }
          //         }),
          //       ),
          //     ),
          //     contentPadding: const EdgeInsets.all(2),
          //   ),
          // ),
          // ),
          // )
        ],
      ),
    );
  }
}
