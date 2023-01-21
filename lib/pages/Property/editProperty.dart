import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProperty extends StatelessWidget {
  final Map map;

  const EditProperty({Key? key, required this.map}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = map['id'];
    String title = map['title'];
    String description = map['description'];
    String price = map['price'];
    String address = map['address'];
    String city = map['city'];
    String type = map['type'];
    String property_type = map['property_type'];
    String purpose = map['purpose'];
    String land_area = map['land_area'];
    String year_build = map['year_build'];
    String primary_image = map['primary_image'];
    String public_user_id = map['public_user_id'];
    String video_link = map['video_link'];
    String verification_status = map['verification_status'];
    String featured = map['featured'];
    String timestamp = map['timestamp'];
    String message = map['message'];

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(40))),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(0),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  CachedNetworkImage(
                      imageUrl: primary_image,
                      height: 350,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.transparent, width: 5),
                              color: Colors.transparent),
                          child: Icon(
                            Icons.check_circle_sharp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          ' Purpose',
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: Text(purpose,
                        style: const TextStyle(color: Colors.white)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Purpose'),
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    child: const ListTile(
                                      title: Text('Sale'),
                                    ),
                                    onTap: () {
                                      purpose = 'Sale';
                                      print('Sale');
                                    },
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print('Exchange');
                                      purpose = 'Exchnage';
                                    },
                                    child: const ListTile(
                                      title: Text('Exchange'),
                                    ),
                                  ),
                                ],
                              ),

                              // FutureBuilder(
                              //   future: dbclass.checkUser(email),
                              //   builder: (context, snapshot) {
                              //     if (snapshot.hasData) {
                              //       return Text(snapshot.data.toString());
                              //     } else {
                              //       return Text(
                              //           'A link has been sent to your Email.');
                              //     }
                              //   },
                              // ),
                              // Text('this ?'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  // CustomRadioButton(
                  //   shapeRadius: 100.0,
                  //   radius: 100.0,
                  //   elevation: 0,
                  //   absoluteZeroSpacing: false,
                  //   unSelectedColor: Theme.of(context).canvasColor,
                  //   buttonLables: ['Exchange', 'Sale'],
                  //   buttonValues: ["Exchange", "Sale"],
                  //   buttonTextStyle: ButtonTextStyle(
                  //       selectedColor: Colors.white,
                  //       unSelectedColor: Colors.black,
                  //       textStyle: GoogleFonts.ubuntu(fontSize: 14)),
                  //   radioButtonValue: (value) {
                  //     // dbclass.setPurpose(value.toString());
                  //     // purpose = value.toString();
                  //     print(value);
                  //   },
                  //   selectedColor: Theme.of(context).primaryColor,
                  // ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.transparent, width: 5),
                              color: Colors.transparent),
                          child: Icon(
                            Icons.landscape,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          ' Select Property Type',
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child:
                        Text(type, style: const TextStyle(color: Colors.white)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Property Type'),
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    child: const ListTile(
                                      title: Text('Commercial'),
                                    ),
                                    onTap: () {
                                      type = 'Commercial';
                                      print('Commercial');
                                    },
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print('Residential');
                                      type = 'Residential';
                                    },
                                    child: const ListTile(
                                      title: Text('Residential'),
                                    ),
                                  ),
                                ],
                              ),

                              // FutureBuilder(
                              //   future: dbclass.checkUser(email),
                              //   builder: (context, snapshot) {
                              //     if (snapshot.hasData) {
                              //       return Text(snapshot.data.toString());
                              //     } else {
                              //       return Text(
                              //           'A link has been sent to your Email.');
                              //     }
                              //   },
                              // ),
                              // Text('this ?'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  // CustomRadioButton(
                  //   shapeRadius: 100.0,
                  //   radius: 100.0,
                  //   elevation: 0,
                  //   absoluteZeroSpacing: false,
                  //   unSelectedColor: Theme.of(context).canvasColor,
                  //   buttonLables: ['Exchange', 'Sale'],
                  //   buttonValues: ["Exchange", "Sale"],
                  //   buttonTextStyle: ButtonTextStyle(
                  //       selectedColor: Colors.white,
                  //       unSelectedColor: Colors.black,
                  //       textStyle: GoogleFonts.ubuntu(fontSize: 14)),
                  //   radioButtonValue: (value) {
                  //     // dbclass.setPurpose(value.toString());
                  //     // purpose = value.toString();
                  //     print(value);
                  //   },
                  //   selectedColor: Theme.of(context).primaryColor,
                  // ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.transparent, width: 5),
                              color: Colors.transparent),
                          child: Icon(
                            Icons.landscape,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          ' Type',
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: Text(property_type,
                        style: const TextStyle(color: Colors.white)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Type'),
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    child: const ListTile(
                                      title: Text('Vehicle'),
                                    ),
                                    onTap: () {
                                      property_type = 'Sale';
                                      print(
                                        'Vehicle',
                                      );
                                    },
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print('Land');
                                      property_type = 'Land';
                                    },
                                    child: const ListTile(
                                      title: Text('Land'),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print('Plot');
                                      property_type = 'Plot';
                                    },
                                    child: const ListTile(
                                      title: Text('Plot'),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print('Shop');
                                      property_type = 'Shop';
                                    },
                                    child: const ListTile(
                                      title: Text('Shop'),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print('Office');
                                      property_type = 'Office';
                                    },
                                    child: const ListTile(
                                      title: Text('Office'),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print('Restaurant');
                                      property_type = 'Restaurant';
                                    },
                                    child: const ListTile(
                                      title: Text('Restaurant'),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print('Studio');
                                      property_type = 'Studio';
                                    },
                                    child: const ListTile(
                                      title: Text('Studio'),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print('Apartment');
                                      property_type = 'Apartment';
                                    },
                                    child: const ListTile(
                                      title: Text('Apartment'),
                                    ),
                                  ),
                                ],
                              ),

                              // FutureBuilder(
                              //   future: dbclass.checkUser(email),
                              //   builder: (context, snapshot) {
                              //     if (snapshot.hasData) {
                              //       return Text(snapshot.data.toString());
                              //     } else {
                              //       return Text(
                              //           'A link has been sent to your Email.');
                              //     }
                              //   },
                              // ),
                              // Text('this ?'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  // CustomRadioButton(
                  //   shapeRadius: 100.0,
                  //   radius: 100.0,
                  //   elevation: 0,
                  //   absoluteZeroSpacing: false,
                  //   unSelectedColor: Theme.of(context).canvasColor,
                  //   buttonLables: ['Exchange', 'Sale'],
                  //   buttonValues: ["Exchange", "Sale"],
                  //   buttonTextStyle: ButtonTextStyle(
                  //       selectedColor: Colors.white,
                  //       unSelectedColor: Colors.black,
                  //       textStyle: GoogleFonts.ubuntu(fontSize: 14)),
                  //   radioButtonValue: (value) {
                  //     // dbclass.setPurpose(value.toString());
                  //     // purpose = value.toString();
                  //     print(value);
                  //   },
                  //   selectedColor: Theme.of(context).primaryColor,
                  // ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.transparent, width: 5),
                              color: Colors.transparent),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          ' City',
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  // Text('this text ?'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // onChanged: (value) async {
                      //   dbclass.setCity(value.toString());
                      // },
                      // controller: cityController,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.ubuntu(),
                        hintText: 'dbclass.initial_city',
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            Center(
              child: Text(map['primary_image'].toString()),
            ),
          ],
        ),
      ),
    );
  }
}
