import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../models/database.dart';
import '../pages/search/search.dart';
import 'city_helper.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController typeAheadController2 = TextEditingController();

    var dbclass = context.read<DataBase>();

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
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    print('cool');
                    // searchBottomSheet(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchPage()));
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
                                      child: TypeAheadFormField<String>(
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
                                                  color: Colors.black12),
                                            ),
                                            focusedBorder: InputBorder.none,
                                            hintText: 'Search City...',
                                          ),
                                        ),
                                        suggestionsCallback: (query) {
                                          return CityHelper.getSuggestions(
                                              query);
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please Enter City Name';
                                          }
                                          return null;
                                        },
                                        itemBuilder: (context, suggestion) {
                                          final city = suggestion as String;

                                          return ListTile(
                                            title: Text(city),
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
                                        onSuggestionSelected: (suggestion) {
                                          final city = suggestion as String;

                                          typeAheadController2.text = city;
                                          dbclass.setCity(city);
                                          Navigator.pop(context);
                                        },
                                      ),
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
                        child: Consumer<DataBase>(
                            builder: (context, value, child) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(AntIcons.environmentOutlined,
                                  color: Theme.of(context).primaryColor),
                              Text(
                                " ${value.initial_city}",
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
        ],
      ),
    );
  }
}
