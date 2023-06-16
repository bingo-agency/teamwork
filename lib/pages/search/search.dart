import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/models/database.dart';

import '../../widgets/city_helper.dart';

class SearchPage extends StatefulWidget {
  // String id;
  // SearchPage({Key? key, required this.id}) : super(key: key);
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController typeAheadController2 = TextEditingController();
    String internalLeadId = '';
    String city = '';
    String keyword = '';
    double minPrice = 0;
    double maxPrice = 1000000;
    double minArea = 0;
    double maxArea = 1000000;

    final formKey = GlobalKey<FormState>();
    var dbclass = context.read<DataBase>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(AntIcons.searchOutlined,
                            color: Theme.of(context).primaryColor),
                        const SizedBox(
                          width: 2.0,
                        ),
                        Text(
                          'Search Filters',
                          style: GoogleFonts.ubuntu(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Internal Lead ID',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(AntIcons.fileProtectOutlined),
                        prefixIconColor: Theme.of(context).primaryColor,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Internal Lead ID';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        internalLeadId = value;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1.0,
                          ),
                        ),
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
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          onTap: () async {
                                            await dbclass.getPermission();
                                            dbclass.getCurrentlocation();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(2),
                                          child: TypeAheadFormField<String>(
                                            hideSuggestionsOnKeyboardHide:
                                                false,
                                            textFieldConfiguration:
                                                TextFieldConfiguration(
                                              focusNode: FocusScopeNode(),
                                              enableSuggestions: false,
                                              autofocus: false,
                                              controller: typeAheadController2,
                                              decoration: InputDecoration(
                                                hintStyle:
                                                    GoogleFonts.montserrat(),
                                                border:
                                                    const OutlineInputBorder(
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
                                              if (value == null ||
                                                  value.isEmpty) {
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
                                              height: 15,
                                              child: Center(
                                                child: Text(
                                                  'No City Found.',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onSuggestionSelected: (suggestion) {
                                              final city = suggestion as String;

                                              typeAheadController2.text = city;
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
                            padding: const EdgeInsets.all(15),
                            child: Consumer<DataBase>(
                                builder: (context, value, child) {
                              return Row(
                                mainAxisSize: MainAxisSize.max,
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

                      // Consumer<DataBase>(
                      //   builder: (context, val, child) {
                      //     return Container(
                      //       decoration: BoxDecoration(
                      //         border: Border.all(
                      //           color: Theme.of(context).primaryColor,
                      //           width: 1.0,
                      //         ),
                      //       ),
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: DropdownButtonHideUnderline(
                      //         child: DropdownButton<String>(
                      //           isExpanded: true,
                      //           borderRadius: const BorderRadius.all(
                      //               Radius.circular(10.0)),
                      //           value: val.selectedAdCity,
                      //           items: val.adCityOptions.map((String value) {
                      //             return DropdownMenuItem<String>(
                      //               value: value,
                      //               child: Text(
                      //                 value,
                      //                 style: GoogleFonts.ubuntu(
                      //                     color:
                      //                         Theme.of(context).primaryColor),
                      //               ),
                      //             );
                      //           }).toList(),
                      //           onChanged: (newAdCity) {
                      //             val.setAdCity(newAdCity);
                      //             val.selectedAdCity = val.finalAdCity;
                      //             dbclass.finalAdCity = newAdCity.toString();
                      //             dbclass.adCity = newAdCity.toString();
                      //             print(dbclass.adCity);
                      //           },
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    ),
                    const SizedBox(height: 16.0),
                    // keyword
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Keyword',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(AntIcons.keyOutlined),
                        prefixIconColor: Theme.of(context).primaryColor,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a keyword';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        keyword = value;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    const Divider(),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(AntIcons.auditOutlined,
                            color: Theme.of(context).primaryColor),
                        const SizedBox(
                          width: 2.0,
                        ),
                        Text(
                          'Apply Filters',
                          style: GoogleFonts.ubuntu(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    //min price max price
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              labelText: 'Min Price',
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(AntIcons.walletOutlined),
                              prefixIconColor: Theme.of(context).primaryColor,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter min price';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              minPrice = double.parse(value);
                            },
                          ),
                        ),
                        Flexible(
                          child: TextFormField(
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              labelText: 'Max Price',
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(AntIcons.walletOutlined),
                              prefixIconColor: Theme.of(context).primaryColor,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Max price';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              maxPrice = double.parse(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    RangeSlider(
                        values: RangeValues(minPrice, maxPrice),
                        min: 0,
                        max: 1000000,
                        onChanged: (RangeValues values) {
                          // setState(() {
                          minPrice = values.start;
                          maxPrice = values.end;
                        }),
                    const SizedBox(height: 16.0),
                    // min area max area
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              labelText: 'Min Area',
                              border: const OutlineInputBorder(),
                              prefixIcon:
                                  const Icon(AntIcons.fullscreenOutlined),
                              prefixIconColor: Theme.of(context).primaryColor,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter min area';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              minArea = double.parse(value);
                            },
                          ),
                        ),
                        Flexible(
                          child: TextFormField(
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              labelText: 'Max Area',
                              border: const OutlineInputBorder(),
                              prefixIcon:
                                  const Icon(AntIcons.fullscreenOutlined),
                              prefixIconColor: Theme.of(context).primaryColor,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Max Area';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              maxArea = double.parse(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    RangeSlider(
                        values: RangeValues(minArea, maxArea),
                        min: 0,
                        max: 1000000,
                        onChanged: (RangeValues values) {
                          // setState(() {
                          minArea = values.start;
                          maxArea = values.end;
                        }),
                    const SizedBox(height: 16.0),

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
                              'Search with Property Type',
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
                                value: val.selectedSearchType,
                                items:
                                    val.typeSearchOptions.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.ubuntu(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newSearchType) {
                                  val.setSearchType(newSearchType);
                                  val.selectedSearchType = val.finalSearchType;
                                  dbclass.finalSearchType =
                                      newSearchType.toString();
                                  print(newSearchType);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    const Divider(),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      // color: Colors.red,
                      // textColor: Colors.white,
                      child: const Text('Apply Filters'),
                      onPressed: () {
                        print('Send to search page with new curl');
                        // TODO: Implement delete profile functionality
                      },
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
