import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:team_work/models/database.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../widgets/city_helper.dart';
import '../auth/manageAds.dart';

class AddNewProperty extends StatelessWidget {
  String id;
  AddNewProperty({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbclass = context.read<DataBase>();

    String id = dbclass.id;
    // final scaffoldKey = GlobalKey<ScaffoldState>();
    // final addPropertyForm = GlobalKey<FormState>();
    final TextEditingController typeAheadController2 = TextEditingController();
    // final addPropertyForm = GlobalKey<FormState>();
    // GlobalKey<FormState> addPropertyForm = GlobalKey<FormState>();

    return Scaffold(
        // key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Add New Property",
            style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w700, color: Colors.white),
          ),
          leading: const BackButton(
            color: Colors.white, // <-- SEE HERE
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0),
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              "https://teamworkpk.com/img/adPrpty.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        // key: addPropertyForm,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          children: [
                            // Basic Details
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(AntIcons.homeOutlined,
                                            color:
                                                Theme.of(context).primaryColor),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          'Basic Details',
                                          style: GoogleFonts.ubuntu(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0),
                                        ),
                                      ],
                                    ),
                                    (dbclass.adInternalId == "")
                                        ? IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      'Add Internal ID',
                                                      style:
                                                          GoogleFonts.ubuntu(),
                                                    ),
                                                    content: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Internal ID',
                                                        border:
                                                            const OutlineInputBorder(),
                                                        prefixIcon: const Icon(
                                                            AntIcons
                                                                .fileProtectOutlined),
                                                        prefixIconColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                      ),
                                                      onChanged: (value) {
                                                        dbclass.adInternalId =
                                                            value.toString();
                                                        print(value);
                                                      },
                                                      // controller: locationController,
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                        child: Text('Add',
                                                            style: GoogleFonts
                                                                .ubuntu()),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              print('Add internal ID');
                                            },
                                            icon: Icon(
                                              AntIcons.fileProtectOutlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          )
                                        : Text(dbclass.adInternalId.toString(),
                                            style: GoogleFonts.ubuntu()),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.blueGrey.shade200,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(AntIcons.buildOutlined,
                                        color: Theme.of(context).primaryColor),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Select Ad Type',
                                      style: GoogleFonts.ubuntu(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CustomRadioButton(
                              height: 50.0,
                              horizontal: false,
                              customShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              selectedBorderColor:
                                  Theme.of(context).primaryColor,
                              disabledColor: Colors.grey,
                              shapeRadius: BorderSide.strokeAlignCenter,
                              autoWidth: true,
                              enableButtonWrap: false,
                              defaultSelected: 'Residential',
                              elevation: 1,
                              absoluteZeroSpacing: true,
                              unSelectedColor: Theme.of(context).canvasColor,
                              buttonLables: const [
                                'Residential',
                                'Commercial',
                              ],
                              buttonValues: const [
                                "Residential",
                                "Commercial",
                              ],
                              buttonTextStyle: ButtonTextStyle(
                                selectedColor: Colors.white,
                                unSelectedColor: Colors.black,
                                textStyle: GoogleFonts.ubuntu(fontSize: 16),
                              ),
                              radioButtonValue: (value) {
                                dbclass.adPropertyType = value.toString();
                                print(value);
                              },
                              enableShape: true,
                              margin: const EdgeInsets.all(2.0),
                              selectedColor: Theme.of(context).primaryColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(AntIcons.swapOutlined,
                                        color: Theme.of(context).primaryColor),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Select Purpose',
                                      style: GoogleFonts.ubuntu(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CustomRadioButton(
                              height: 50.0,
                              horizontal: false,
                              customShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              selectedBorderColor:
                                  Theme.of(context).primaryColor,
                              disabledColor: Colors.grey,
                              shapeRadius: BorderSide.strokeAlignCenter,
                              autoWidth: true,
                              enableButtonWrap: false,
                              defaultSelected: 'Exchange',
                              elevation: 1,
                              absoluteZeroSpacing: true,
                              unSelectedColor: Theme.of(context).canvasColor,
                              buttonLables: const [
                                'Exchange',
                                'Sale',
                              ],
                              buttonValues: const [
                                "Exchange",
                                "Sale",
                              ],
                              buttonTextStyle: ButtonTextStyle(
                                selectedColor: Colors.white,
                                unSelectedColor: Colors.black,
                                textStyle: GoogleFonts.ubuntu(fontSize: 16),
                              ),
                              radioButtonValue: (value) {
                                dbclass.adPurpose = value.toString();
                                print(value);
                              },
                              enableShape: true,
                              margin: const EdgeInsets.all(2.0),
                              selectedColor: Theme.of(context).primaryColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(AntIcons.bankOutlined,
                                        color: Theme.of(context).primaryColor),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Select Property Type',
                                      style: GoogleFonts.ubuntu(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Consumer<DataBase>(
                                builder: (context, val, child) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        value: val.selectedType,
                                        items:
                                            val.typeOptions.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: GoogleFonts.ubuntu(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (newType) {
                                          val.setType(newType);
                                          val.selectedType = val.finalType;
                                          dbclass.finalType =
                                              newType.toString();
                                          dbclass.adType = newType.toString();
                                          print(newType);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // select property type heading
                            //select city
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 1.0,
                                  ),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // print('cities were tapped !!!');
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Select City',
                                            style: GoogleFonts.ubuntu(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                      'Get City From Gps',
                                                      style:
                                                          GoogleFonts.ubuntu()),
                                                  leading: Icon(
                                                    Icons.gps_fixed_outlined,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  onTap: () async {
                                                    await dbclass
                                                        .getPermission();
                                                    dbclass
                                                        .getCurrentlocation();
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  child: TypeAheadFormField<
                                                      String>(
                                                    hideSuggestionsOnKeyboardHide:
                                                        false,
                                                    textFieldConfiguration:
                                                        TextFieldConfiguration(
                                                      focusNode:
                                                          FocusScopeNode(),
                                                      enableSuggestions: false,
                                                      autofocus: false,
                                                      controller:
                                                          typeAheadController2,
                                                      decoration:
                                                          InputDecoration(
                                                        hintStyle: GoogleFonts
                                                            .montserrat(),
                                                        border:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black12),
                                                        ),
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Search City...',
                                                      ),
                                                    ),
                                                    suggestionsCallback:
                                                        (query) {
                                                      return CityHelper
                                                          .getSuggestions(
                                                              query);
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please Enter City Name';
                                                      }
                                                      return null;
                                                    },
                                                    itemBuilder:
                                                        (context, suggestion) {
                                                      final city =
                                                          suggestion as String;

                                                      return ListTile(
                                                        title: Text(city),
                                                      );
                                                    },
                                                    noItemsFoundBuilder:
                                                        (context) =>
                                                            const SizedBox(
                                                      height: 15,
                                                      child: Center(
                                                        child: Text(
                                                          'No City Found.',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    onSuggestionSelected:
                                                        (suggestion) {
                                                      final city =
                                                          suggestion as String;

                                                      typeAheadController2
                                                          .text = city;
                                                      dbclass.adCity = city;
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
                                    padding: const EdgeInsets.all(5),
                                    child: Consumer<DataBase>(
                                        builder: (context, value, child) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(AntIcons.environmentOutlined,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          Text(
                                            " ${value.initial_city}",
                                            softWrap: true,
                                            style: GoogleFonts.ubuntu(
                                                color: Theme.of(context)
                                                    .primaryColor,
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
                            // select locaiton heading

                            //location

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Consumer<DataBase>(
                                builder: (context, db, _) {
                                  return TextFormField(
                                    controller: TextEditingController(
                                        text: db.adLocation),
                                    decoration: InputDecoration(
                                      labelText: 'Location',
                                      border: const OutlineInputBorder(),
                                      suffixIconColor:
                                          Theme.of(context).primaryColor,
                                      suffixIcon: GestureDetector(
                                        onTap: () async {
                                          print('Get location here instead.');

                                          await dbclass.getPermission();
                                          dbclass.getCurrentlocation();

                                          dbclass.adLocation =
                                              await dbclass.formattedAddress;
                                          print(dbclass.adLocation);
                                        },
                                        child: const Icon(
                                            AntIcons.environmentOutlined),
                                      ),
                                      prefixIcon:
                                          const Icon(AntIcons.globalOutlined),
                                      prefixIconColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter your Locaiton';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        dbclass.adLocation =
                                            dbclass.formattedAddress.toString();
                                      } else {
                                        dbclass.adLocation = value;
                                      }
                                      dbclass.adLocation = value.toString();
                                      print(dbclass.adLocation);
                                    },
                                    // controller: locationController,
                                  );
                                },
                              ),
                            ),
                            // Select Location
                            InkWell(
                              onTap: () async {
                                showMapDialog(context);
                                // print(dbclass.formattedAddress);
                                // await dbclass.getPermission();
                                // dbclass.getCurrentlocation();

                                // final db = Provider.of<DataBase>(context,
                                //     listen: false);
                                // final result = await showDialog<LatLng>(
                                //   context: context,
                                //   builder: (context) {
                                //     return AlertDialog(
                                //       content: SizedBox(
                                //         width: double.maxFinite,
                                //         child: GoogleMap(
                                //           initialCameraPosition: CameraPosition(
                                //             target: db.currentLocation,
                                //             zoom: 12,
                                //           ),
                                //           onMapCreated: (controller) {},
                                //           markers: {
                                //             Marker(
                                //               draggable: true,
                                //               markerId: const MarkerId(
                                //                   'current_location'),
                                //               position: db.currentLocation,
                                //             ),
                                //           },
                                //           onTap: (location) {
                                //             db.x = location.latitude;
                                //             db.y = location.longitude;
                                //             db.Getlocation(db.x.toString(),
                                //                 db.y.toString());
                                //             db.currentLocation = location;
                                //             final newPosition =
                                //                 LatLng(db.x, db.y);
                                //             db.currentLocation = newPosition;
                                //             Provider.of<DataBase>(context,
                                //                     listen: false)
                                //                 .currentLocation = newPosition;
                                //             // db.currentLocation(newPosition);
                                //             Marker(
                                //               markerId: const MarkerId(
                                //                   'current_location'),
                                //               position: newPosition,
                                //             );
                                //             // Navigator.of(context).pop();
                                //           },
                                //         ),
                                //       ),
                                //       actions: [
                                //         ElevatedButton(
                                //           onPressed: () {
                                //             Navigator.pop(context);
                                //           },
                                //           child: const Text('OK'),
                                //         ),
                                //       ],
                                //     );
                                //   },
                                // );
                                // if (result != null) {
                                //   final db = Provider.of<DataBase>(context,
                                //       listen: false);
                                //   db.currentLocation = result;
                                // }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(35.0),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Icon(
                                            AntIcons.environmentOutlined,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Get Location from Map.',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              height: 30.0,
                              color: Colors.transparent,
                            ),
                            //priceArea Heading.
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(AntIcons.tagOutlined,
                                        color: Theme.of(context).primaryColor),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Price & Area',
                                      style: GoogleFonts.ubuntu(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.blueGrey.shade200,
                            ),
                            // Area Size
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Area Size',
                                        border: const OutlineInputBorder(),
                                        prefixIcon: const Icon(
                                            AntIcons.fullscreenOutlined),
                                        prefixIconColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Units';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        dbclass.adArea = value.toString();
                                      },
                                      // controller: locationController,
                                    ),
                                  ),
                                  Consumer<DataBase>(
                                    builder: (context, val, child) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton<String>(
                                          value: val.selectedUnit,
                                          items: val.unitOptions
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (newUnit) {
                                            val.setUnit(newUnit);
                                            val.selectedUnit = val.finalUnit;
                                            dbclass.finalUnit =
                                                newUnit.toString();
                                            print(newUnit);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            //price
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 30.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        CommaTextInputFormatter(),
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Price',
                                        border: const OutlineInputBorder(),
                                        prefixIcon:
                                            const Icon(AntIcons.walletOutlined),
                                        prefixIconColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your Locaiton';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        dbclass.adPrice = value.toString();
                                        print(dbclass.adPrice);
                                      },
                                      // controller: locationController,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      ' - PKR',
                                      style: GoogleFonts.ubuntu(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50.0),
                            // Add information title
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(AntIcons.homeOutlined,
                                        color: Theme.of(context).primaryColor),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Add information',
                                      style: GoogleFonts.ubuntu(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.blueGrey.shade200,
                            ),
                            //Enter title
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Title',
                                  border: const OutlineInputBorder(),
                                  prefixIcon:
                                      const Icon(AntIcons.lineHeightOutlined),
                                  prefixIconColor:
                                      Theme.of(context).primaryColor,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Title : Beautiful House in Bahria phase 8';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  dbclass.adTitle = value.toString();
                                },
                                // controller: locationController,
                              ),
                            ),
                            //Enter Description

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                minLines: 10,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  border: const OutlineInputBorder(),
                                  prefixIcon:
                                      const Icon(AntIcons.alignLeftOutlined),
                                  prefixIconColor:
                                      Theme.of(context).primaryColor,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Describe your property, its area, Locaiton and other advantages.';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  dbclass.adDescription = value.toString();
                                },
                                // controller: locationController,
                              ),
                            ),
                            const SizedBox(height: 50.0),
                            // Adding images and videos title
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(AntIcons.fileImageOutlined,
                                        color: Theme.of(context).primaryColor),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Add Images & Video links',
                                      style: GoogleFonts.ubuntu(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.blueGrey.shade200,
                            ),
                            // Select images
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(AntIcons.pictureOutlined,
                                        color: Theme.of(context).primaryColor),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Select images',
                                      style: GoogleFonts.ubuntu(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //select actual images.
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                height: 300,
                                child: SafeArea(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Consumer<DataBase>(
                                          builder: (context, db, _) {
                                            return (db.imageFiles.length > 1)
                                                ? ListView.builder(
                                                    addAutomaticKeepAlives:
                                                        true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    itemCount:
                                                        db.imageFiles.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final file =
                                                          db.imageFiles[index];
                                                      return Card(
                                                        elevation: 5.0,
                                                        child: Column(
                                                          children: [
                                                            Image.file(
                                                              file,
                                                              width: 250,
                                                              height: 220,
                                                              fit: BoxFit.cover,
                                                            ),
                                                            IconButton(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              icon: const Icon(
                                                                  AntIcons
                                                                      .deleteOutlined),
                                                              onPressed: () =>
                                                                  db.removeImage(
                                                                      index),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : InkWell(
                                                    onTap: () =>
                                                        Provider.of<DataBase>(
                                                                context,
                                                                listen: false)
                                                            .selectImages(),
                                                    child: Card(
                                                      child: SizedBox(
                                                          height: 300,
                                                          child: Center(
                                                            child: Text(
                                                              'No Images Selected yet.',
                                                              style: GoogleFonts.ubuntu(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      22.0),
                                                            ),
                                                          )),
                                                    ),
                                                  );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // add youtube link
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(AntIcons.videoCameraOutlined,
                                        color: Theme.of(context).primaryColor),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Add a youTube link',
                                      style: GoogleFonts.ubuntu(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // add actual youTube link
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.url,
                                decoration: const InputDecoration(
                                    labelText: 'YouTube Video Link'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Add your property link.';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  print(value);
                                  dbclass.adVideoLink = value.toString();
                                },
                              ),
                            ),
                            // add property button
                            InkWell(
                              onTap: () async {
                                if (dbclass.uploadValue == false) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Adding'),
                                        content: Row(
                                          children: [
                                            const CircularProgressIndicator(),
                                            const SizedBox(width: 10.0),
                                            Text(
                                                'Adding your property, Please wait....',
                                                style: GoogleFonts.ubuntu()),
                                          ],
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                print('internal id = ' +
                                    dbclass.adInternalId +
                                    ' type = ' +
                                    dbclass.adType +
                                    'purpose = ' +
                                    dbclass.adPurpose +
                                    ' city = ' +
                                    dbclass.adCity +
                                    'locaiton = ' +
                                    dbclass.adLocation +
                                    'area = ' +
                                    dbclass.adArea +
                                    'price = ' +
                                    dbclass.adPrice +
                                    'title = ' +
                                    dbclass.adTitle +
                                    'description = ' +
                                    dbclass.adDescription +
                                    'video link = ' +
                                    dbclass.adVideoLink);
                                await dbclass
                                    .addNewProperty(
                                        context,
                                        dbclass.adInternalId,
                                        dbclass.adType,
                                        dbclass.adPurpose,
                                        dbclass.adCity,
                                        dbclass.adLocation,
                                        dbclass.adArea,
                                        dbclass.adPrice,
                                        dbclass.adTitle,
                                        dbclass.adDescription,
                                        dbclass.adVideoLink,
                                        dbclass.adPropertyType)
                                    .whenComplete(() {
                                  print('property been added.');
                                  Navigator.of(context).pop();
                                  dbclass.adInternalId = '';
                                  dbclass.adType = '';
                                  dbclass.adPurpose = '';
                                  dbclass.adCity = '';
                                  dbclass.adLocation = '';
                                  dbclass.adArea = '';
                                  dbclass.adPrice = '';
                                  dbclass.adTitle = '';
                                  dbclass.adDescription = '';
                                  dbclass.adVideoLink = '';
                                  dbclass.adPropertyType = '';
                                  dbclass.image_Files = [];
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ManageAds(id: dbclass.id)),
                                      (route) => false);
                                });
                                print('add property tapped.');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Center(
                                      child: Text(
                                        'Add Property',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                        ),
                                        // style:GoogleFonts.ubuntu(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Add information title
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class CommaTextInputFormatter extends TextInputFormatter {
  final _formatter = NumberFormat('#,###');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final oldValueString = oldValue.text.replaceAll(',', '');
    final newValueString = newValue.text.replaceAll(',', '');
    if (oldValueString == newValueString) {
      return newValue;
    }
    final newValueNumber = int.tryParse(newValueString);
    if (newValueNumber == null) {
      return oldValue;
    }
    final newString = _formatter.format(newValueNumber);
    return newValue.copyWith(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}

void showMapDialog(BuildContext context) async {
  final db = Provider.of<DataBase>(context, listen: false);
  final result = await showDialog<LatLng>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          child: GoogleMap(
            mapType: MapType.terrain,
            initialCameraPosition: CameraPosition(
              target: db.currentLocation,
              zoom: 12,
            ),
            markers: <Marker>{
              Marker(
                draggable: true,
                markerId: const MarkerId("Selected Location"),
                position: LatLng(db.x, db.y),
                // icon: MarkerIcon(icon:AntIcons.accountBookFilled,color:Theme.of(context).primaryColor),
                infoWindow: const InfoWindow(
                  title: 'Select your location',
                ),
              )
            },
            onCameraMove: (CameraPosition position) {
              final db = Provider.of<DataBase>(context, listen: false);
              db.currentLocation = position.target;
              Provider.of<DataBase>(context, listen: false).currentLocation =
                  position.target;
            },
            onMapCreated: (GoogleMapController controller) {
              final db = Provider.of<DataBase>(context, listen: false);
              db.mapController = controller;
            },
            onTap: (location) {
              db.x = location.latitude;
              db.y = location.longitude;
              db.Getlocation(db.x.toString(), db.y.toString());
              db.currentLocation = location;
              final newPosition = LatLng(db.x, db.y);
              db.currentLocation = newPosition;
              Provider.of<DataBase>(context, listen: false).currentLocation =
                  newPosition;
              final marker = Marker(
                markerId: const MarkerId('current_location'),
                position: newPosition,
              );
              Provider.of<DataBase>(context, listen: false)
                  .markers['current_location'] = marker;
              Navigator.of(context).pop();
            },
          ),
        ),
      );
    },
  );
  if (result != null) {
    final db = Provider.of<DataBase>(context, listen: false);
    db.currentLocation = result;
  }
}
