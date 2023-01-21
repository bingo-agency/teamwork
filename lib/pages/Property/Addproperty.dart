import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

import '../../models/database.dart';

import '../auth/manageAds.dart';

class Addproperty extends StatelessWidget {
  final String id;

  const Addproperty({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> purposeList = const ['Exchange', 'Sale'];

    var dbclass = context.read<DataBase>();

    String purpose = dbclass.purposeIndex.toString();
    String type = dbclass.typeIndex.toString();
    String property_type = dbclass.propertyTypeIndex.toString();
    String city = dbclass.initial_city;
    String address = dbclass.addressIndex.toString();
    String yearBuild = dbclass.yearBuildIndex.toString();
    String price = dbclass.priceIndex.toString();
    String title = dbclass.titleIndex.toString();
    String description = dbclass.descriptionIndex.toString();
    String id = dbclass.id;

    TextEditingController addressController =
        TextEditingController(text: address);
    final yearBuildController = TextEditingController(text: yearBuild);
    final priceController = TextEditingController(text: price);
    final titleController = TextEditingController(text: title);
    final descriptionController = TextEditingController(text: description);
    final cityController = TextEditingController(text: city);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                      imageUrl: 'https://teamworkpk.com/img/adPrpty.png'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent, width: 5),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomRadioButton(
                    shapeRadius: 100.0,
                    radius: 100.0,
                    elevation: 0,
                    absoluteZeroSpacing: false,
                    unSelectedColor: Theme.of(context).canvasColor,
                    buttonLables: ['Exchange', 'Sale'],
                    buttonValues: ["Exchange", "Sale"],
                    buttonTextStyle: ButtonTextStyle(
                        selectedColor: Colors.white,
                        unSelectedColor: Colors.black,
                        textStyle: GoogleFonts.ubuntu(fontSize: 14)),
                    radioButtonValue: (value) {
                      dbclass.setPurpose(value.toString());
                      purpose = value.toString();
                      print(value);
                    },
                    selectedColor: Theme.of(context).primaryColor,
                  ),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent, width: 5),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRadioButton(
                      elevation: 0,
                      absoluteZeroSpacing: false,
                      unSelectedColor: Theme.of(context).canvasColor,
                      buttonLables: const ['Commercial', 'Residential'],
                      buttonValues: const ["Commercial", "Residential"],
                      buttonTextStyle: ButtonTextStyle(
                          selectedColor: Colors.white,
                          unSelectedColor: Colors.black,
                          textStyle: GoogleFonts.ubuntu(fontSize: 14)),
                      radioButtonValue: (value) {
                        dbclass.setType(value.toString());
                        type = value.toString();
                        print(value);
                      },
                      selectedColor: Theme.of(context).primaryColor,
                    ),
                  ]),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      CustomRadioButton(
                        elevation: 1,
                        absoluteZeroSpacing: false,
                        unSelectedColor: Theme.of(context).canvasColor,
                        buttonLables: const [
                          'Vehicle',
                          'Land',
                          'Plot',
                          'Shop',
                          'Office',
                          'Restaurant',
                          'Studio',
                          'Apartment'
                        ],
                        buttonValues: const [
                          'Vehicle',
                          'Land',
                          'Plot',
                          'Shop',
                          'Office',
                          'Restaurant',
                          'Studio',
                          'Apartment'
                        ],
                        buttonTextStyle: ButtonTextStyle(
                            selectedColor: Colors.white,
                            unSelectedColor: Colors.black,
                            textStyle: GoogleFonts.ubuntu(fontSize: 14)),
                        radioButtonValue: (value) {
                          property_type = value.toString();
                          dbclass.setproperty_type(value.toString());
                          print(value);
                        },
                        selectedColor: Theme.of(context).primaryColor,
                      ),
                    ]),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent, width: 5),
                        color: Colors.transparent),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    dbclass.initial_city,
                    style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) async {
                    dbclass.setCity(value.toString());
                  },
                  controller: cityController,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.ubuntu(),
                    hintText: dbclass.initial_city,
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent, width: 5),
                        color: Colors.transparent),
                    child: Icon(
                      Icons.gps_fixed,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    ' Street Address',
                    style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) async {
                    dbclass.setAddress(value.toString());
                  },
                  controller: addressController,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.ubuntu(),
                    hintText: 'House 123, Street 456, Sector f/12-3',
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent, width: 5),
                        color: Colors.transparent),
                    child: Icon(
                      Icons.local_hospital_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    ' Year Built',
                    style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) async {
                    dbclass.setYearBuild(value.toString());
                  },
                  controller: yearBuildController,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.ubuntu(),
                    hintText: '2022',
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
            ),
            const SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent, width: 5),
                        color: Colors.transparent),
                    child: Icon(
                      Icons.tag,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    'Price in PKR',
                    style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) async {
                    dbclass.setPrice(value.toString());
                  },
                  controller: priceController,
                  decoration: const InputDecoration(
                    hintText: 'Total price',
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('PKR'),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent, width: 5),
                        color: Colors.transparent),
                    child: Icon(
                      Icons.format_size,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    '  Property Title',
                    style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) async {
                    dbclass.setTitle(value.toString());
                  },
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Title e.g beautiful new house',
                  ),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent, width: 5),
                        color: Colors.transparent),
                    child: Icon(
                      Icons.list,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    '  Property Discription',
                    style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 8,
                  onChanged: (value) async {
                    dbclass.setDescription(value.toString());
                  },
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Describe Your Property in details ',
                  ),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent, width: 5),
                        color: Colors.transparent),
                    child: Icon(
                      Icons.image,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    '  Upload Primary Image of Your Property',
                    style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Consumer<DataBase>(builder: (context, value, child) {
                    return value.primaryImage != null
                        ? Image.file(
                            value.primaryImage!,
                            scale: 1.0,
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            "assets/images/noimage.jpeg",
                            fit: BoxFit.cover,
                          );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      print('this button was hit !');
                      var pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                      dbclass.setPrimaryImage(File(pickedFile!.path));
                      print(dbclass.primaryImage);
                    },
                    child: Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image,
                                color: Theme.of(context).backgroundColor),
                            Text(
                              "Add Primary Image",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<DataBase>(builder: (context, value, child) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        children: List.generate(dbclass.propertyImages.length,
                            (index) {
                          Asset asset = dbclass.propertyImages[index];
                          if (dbclass.propertyImages.isNotEmpty) {
                            return AssetThumb(
                              asset: asset,
                              width: 300,
                              height: 300,
                            );
                          } else {
                            return const GridTile(
                              child: Text('No Images Selected.'),
                            );
                          }
                        }),
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      print(
                          'Gallery button was hit ! will select images now ! ');

                      dbclass.loadAssets();
                    },
                    child: Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image,
                                color: Theme.of(context).backgroundColor),
                            Text(
                              "Add Property Gallery",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      var addproperty = await dbclass.addProperty(
                          id,
                          purpose,
                          type,
                          city,
                          address,
                          yearBuild,
                          price,
                          title,
                          description,
                          property_type);
                      // var postid = await dbclass.post_id;
                      print('printing post id ');
                      // print(postid);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title:
                              Text('Adding Post', style: GoogleFonts.ubuntu()),
                          content: FutureBuilder(
                            future: dbclass.getSpinnerValue(),
                            builder: (context, snapshot) {
                              if (dbclass.showSpinner == true) {
                                print(
                                    'its true for spinner from AdProperty Future...');
                                Timer(
                                    const Duration(seconds: 5),
                                    () => Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ManageAds(id: dbclass.id))));

                                return Container(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  height: 150,
                                  child: const Center(
                                    child: Text('Uploading images...'),
                                  ),
                                );
                              } else {
                                Timer(
                                    const Duration(seconds: 5),
                                    () => Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ManageAds(id: dbclass.id))));

                                print('its true from AdProperty Future...');
                              }
                              if (snapshot.hasData) {
                                print(snapshot.data.toString());
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    Text(
                                      'Uploading - Files',
                                      softWrap: true,
                                      style: GoogleFonts.ubuntu(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    )
                                  ],
                                );
                              } else {
                                return const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop(); // dismisses only the dialog and returns nothing
                              },
                              child: Text(
                                'Next',
                                style: GoogleFonts.ubuntu(),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text(
                        'Post Ad',
                        style: GoogleFonts.ubuntu(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
