import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:team_work/pages/auth/manageAds.dart';
import 'package:team_work/pages/settings/myFavourites.dart';
import 'package:team_work/pages/settings/savedSearch.dart';
import 'package:team_work/pages/settings/settings.dart';
import 'package:team_work/widgets/alertBox.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/database.dart';
import '../Career/contactus.dart';
import '../settings/drafts.dart';
import 'package:in_app_review/in_app_review.dart';

class profilepage extends StatelessWidget {
  String id;

  profilepage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    launchURL() async {
      const url = 'https://teamworkpk.com/terms';
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Settings',
                style: GoogleFonts.ubuntu(
                    fontSize: 30,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<DataBase>(
                        builder: (context, value, child) {
                          return Text(
                            'Welcome,\n${value.name}',
                            style: GoogleFonts.ubuntu(fontSize: 26),
                          );
                        },
                      ),
                      const Text('Basic Plan - 0 PKR/Month'),
                    ],
                  ),
                  SizedBox(
                    width: 120.0,
                    height: 120.0,
                    child: Consumer<DataBase>(
                      builder: (context, value, child) {
                        return (value.image != '')
                            ? InkWell(
                                onTap: () {
                                  alertBox(context,
                                      'This Service is only Available to Premiuim members only.');
                                },
                                child: Card(
                                    elevation: 3.0,
                                    child: CachedNetworkImage(
                                        imageUrl: value.image)),
                              )
                            : const CircularProgressIndicator();
                      },
                    ),
                  ),
                ],
              ),
              Container(
                height: 10.0,
              ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                addAutomaticKeepAlives: true,
                shrinkWrap: true,
                children: [
                  InkWell(
                    onTap: () {
                      // print('Settings were tapped.');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage(id: id)));
                    },
                    child: Card(
                      elevation: 3.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Icon(AntIcons.settingOutlined,
                                  color: Theme.of(context).primaryColor,
                                  size: 40.0),
                            ),
                            Text(
                              'Settings',
                              style: GoogleFonts.ubuntu(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // print('Saved Searches.');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SavedSearch(id: id)));
                    },
                    child: Card(
                      elevation: 3.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Icon(AntIcons.searchOutlined,
                                  color: Theme.of(context).primaryColor,
                                  size: 40.0),
                            ),
                            Text(
                              'Saved Searches',
                              style: GoogleFonts.ubuntu(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // print('Favourites');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => myFavourites(id: id)));
                    },
                    child: Card(
                      elevation: 3.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Icon(AntIcons.heartOutlined,
                                  color: Theme.of(context).primaryColor,
                                  size: 40.0),
                            ),
                            Text(
                              'My Favourites',
                              style: GoogleFonts.ubuntu(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // print('My Properties');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManageAds(id: id)));
                    },
                    child: Card(
                      elevation: 3.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Icon(AntIcons.homeOutlined,
                                  color: Theme.of(context).primaryColor,
                                  size: 40.0),
                            ),
                            Text(
                              'My Properties',
                              style: GoogleFonts.ubuntu(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // print('Drafts');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Drafts(id: id)));
                    },
                    child: Card(
                      elevation: 3.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Icon(AntIcons.picLeftOutlined,
                                  color: Theme.of(context).primaryColor,
                                  size: 40.0),
                            ),
                            Text(
                              'Drafts',
                              style: GoogleFonts.ubuntu(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // print('Shares & Investments');
                      alertBox(context,
                          'This Service is only Available to Premiuim members only.');
                    },
                    child: Card(
                      elevation: 3.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Icon(AntIcons.pieChartOutlined,
                                  color: Theme.of(context).primaryColor,
                                  size: 40.0),
                            ),
                            Text(
                              'My Shares',
                              style: GoogleFonts.ubuntu(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Card(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 4.0, right: 4.0, top: 20.0, bottom: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: SvgPicture.asset(
                                'assets/icons/shape24.svg',
                                width: 52,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                'Looking to Sell or Exchange your Property ?',
                                style: GoogleFonts.ubuntu(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const addProperty(),
                            //   ),
                            // );
                          },
                          child: const Text('Post Your Property Ad Easy'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // list below the post property rect.
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          child: Icon(AntIcons.globalOutlined,
                              size: 40.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              alertBox(context,
                                  'This Service is only Available to Premiuim members only.');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Languages',
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Icon(
                                  AntIcons.rightOutlined,
                                  color: Theme.of(context).primaryColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          child: Icon(AntIcons.contactsOutlined,
                              size: 40.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Contact(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Contact Us',
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Icon(
                                  AntIcons.rightOutlined,
                                  color: Theme.of(context).primaryColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          child: Icon(AntIcons.trophyOutlined,
                              size: 40.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: GestureDetector(
                            onTap: () async {
                              alertBox(context, 'Please Wait,');
                              Navigator.pop(context);
                              final InAppReview inAppReview =
                                  InAppReview.instance;
                              if (await inAppReview.isAvailable()) {
                                inAppReview.requestReview();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Feedback',
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Icon(
                                  AntIcons.rightOutlined,
                                  color: Theme.of(context).primaryColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          child: Icon(AntIcons.userAddOutlined,
                              size: 40.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Invite Friends to TeamWork',
                                style: GoogleFonts.ubuntu(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Icon(
                                AntIcons.rightOutlined,
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          child: Icon(AntIcons.unorderedListOutlined,
                              size: 40.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: GestureDetector(
                            onTap: launchURL,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Terms & Conditions',
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Icon(
                                  AntIcons.rightOutlined,
                                  color: Theme.of(context).primaryColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          child: Icon(AntIcons.logoutOutlined,
                              size: 40.0, color: Colors.redAccent),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              alertBox(context, 'Will work on it later.');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Logout',
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent),
                                ),
                                const Icon(
                                  AntIcons.rightOutlined,
                                  color: Colors.redAccent,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          child: Icon(AntIcons.exclamationCircleOutlined,
                              size: 20.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'App Version 1.3 - Developed by Bingo-Agency.com',
                                style: GoogleFonts.ubuntu(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                    color: Theme.of(context).primaryColor),
                              ),
                              // Icon(
                              //   AntIcons.rightOutlined,
                              //   color: Theme.of(context).primaryColor,
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

    //     body: Container(
    //   color: Colors.white,
    //   child: ListView(
    //     children: <Widget>[
    //       Column(
    //         children: <Widget>[
    //           Container(
    //             height: 250.0,
    //             color: Colors.white,
    //             child: Column(
    //               children: <Widget>[
    //                 Padding(
    //                     padding: const EdgeInsets.only(left: 20.0, top: 20.0),
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: <Widget>[
    //                         InkWell(
    //                           onTap: () {
    //                             Navigator.pop(context);
    //                           },
    //                           child: const Icon(
    //                             Icons.arrow_back_ios,
    //                             color: Colors.black,
    //                             size: 22.0,
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 25.0),
    //                           child: Text('PROFILE',
    //                               style: GoogleFonts.ubuntu(
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 20.0,
    //                                   color: Colors.black)),
    //                         )
    //                       ],
    //                     )),
    //                 Padding(
    //                   padding: const EdgeInsets.only(top: 20.0),
    //                   child: Stack(fit: StackFit.loose, children: <Widget>[
    //                     Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: <Widget>[
    //                         SizedBox(
    //                           width: 140.0,
    //                           height: 140.0,
    //                           child: FutureBuilder(
    //                             future: dbclass.getImage(),
    //                             builder: (BuildContext context,
    //                                 AsyncSnapshot snapshot) {
    //                               if (snapshot.hasData) {
    //                                 return CachedNetworkImage(
    //                                     fit: BoxFit.cover,
    //                                     imageUrl: snapshot.data.toString());
    //                               } else {
    //                                 return const CircularProgressIndicator();
    //                               }
    //                             },
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ]),
    //                 )
    //               ],
    //             ),
    //           ),
    //           FutureBuilder(
    //             initialData: const CircularProgressIndicator(),
    //             builder: (BuildContext context, AsyncSnapshot snapshot) {
    //               if (snapshot.hasData) {
    //                 return Container(
    //                   color: const Color(0xffFFFFFF),
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(bottom: 25.0),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children: <Widget>[
    //                         Padding(
    //                             padding: const EdgeInsets.only(
    //                                 left: 25.0, right: 25.0, top: 25.0),
    //                             child: Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               mainAxisSize: MainAxisSize.max,
    //                               children: <Widget>[
    //                                 Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.start,
    //                                   mainAxisSize: MainAxisSize.min,
    //                                   children: <Widget>[
    //                                     Text(
    //                                       'Personal Information',
    //                                       style: GoogleFonts.ubuntu(
    //                                           fontSize: 18.0,
    //                                           fontWeight: FontWeight.bold),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ],
    //                             )),
    //                         Padding(
    //                             padding: const EdgeInsets.only(
    //                                 left: 25.0, right: 25.0, top: 25.0),
    //                             child: Row(
    //                               mainAxisSize: MainAxisSize.max,
    //                               children: <Widget>[
    //                                 Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.start,
    //                                   mainAxisSize: MainAxisSize.min,
    //                                   children: <Widget>[
    //                                     Text(
    //                                       'Name',
    //                                       style: GoogleFonts.ubuntu(
    //                                           fontSize: 16.0,
    //                                           fontWeight: FontWeight.bold),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ],
    //                             )),
    //                         Padding(
    //                           padding: const EdgeInsets.only(
    //                               left: 25.0, right: 25.0, top: 2.0),
    //                           child: Row(
    //                             mainAxisSize: MainAxisSize.max,
    //                             children: <Widget>[
    //                               Flexible(
    //                                 child: TextFormField(
    //                                   controller: nameController,
    //                                   decoration: const InputDecoration(
    //                                     hintText: "Enter Your Name",
    //                                   ),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(
    //                               left: 25.0, right: 25.0, top: 25.0),
    //                           child: Row(
    //                             mainAxisSize: MainAxisSize.max,
    //                             children: <Widget>[
    //                               Column(
    //                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                 mainAxisSize: MainAxisSize.min,
    //                                 children: <Widget>[
    //                                   Text(
    //                                     'Password',
    //                                     style: GoogleFonts.ubuntu(
    //                                         fontSize: 16.0,
    //                                         fontWeight: FontWeight.bold),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(
    //                               left: 25.0, right: 25.0, top: 2.0),
    //                           child: Row(
    //                             mainAxisSize: MainAxisSize.max,
    //                             children: <Widget>[
    //                               Flexible(
    //                                 child: TextFormField(
    //                                   obscureText: true,
    //                                   controller: passwordController,
    //                                   decoration: const InputDecoration(
    //                                       hintText: "Password"),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(
    //                               left: 25.0, right: 25.0, top: 25.0),
    //                           child: Row(
    //                             mainAxisSize: MainAxisSize.max,
    //                             children: <Widget>[
    //                               Column(
    //                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                 mainAxisSize: MainAxisSize.min,
    //                                 children: <Widget>[
    //                                   Text(
    //                                     'Mobile',
    //                                     style: GoogleFonts.ubuntu(
    //                                         fontSize: 16.0,
    //                                         fontWeight: FontWeight.bold),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(
    //                               left: 25.0, right: 25.0, top: 2.0),
    //                           child: Row(
    //                             mainAxisSize: MainAxisSize.max,
    //                             children: <Widget>[
    //                               Flexible(
    //                                 child: TextFormField(
    //                                   controller: phoneController,
    //                                   decoration: const InputDecoration(
    //                                       hintText: "Enter Mobile Number"),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         // Padding(
    //                         //   padding: const EdgeInsets.only(
    //                         //       left: 25.0, right: 25.0, top: 25.0),
    //                         //   child: Row(
    //                         //     mainAxisSize: MainAxisSize.max,
    //                         //     mainAxisAlignment: MainAxisAlignment.start,
    //                         //     children: <Widget>[
    //                         //       Expanded(
    //                         //         child: Text(
    //                         //           'City',
    //                         //           style: GoogleFonts.ubuntu(
    //                         //               fontSize: 16.0,
    //                         //               fontWeight: FontWeight.bold),
    //                         //         ),
    //                         //         flex: 1,
    //                         //       ),
    //                         //     ],
    //                         //   ),
    //                         // ),
    //                         // Padding(
    //                         //   padding: const EdgeInsets.only(
    //                         //       left: 25.0, right: 25.0, top: 2.0),
    //                         //   child: Row(
    //                         //     mainAxisSize: MainAxisSize.max,
    //                         //     mainAxisAlignment: MainAxisAlignment.start,
    //                         //     children: <Widget>[
    //                         //       Flexible(
    //                         //         child: TextFormField(
    //                         //           // initialValue: dbclass.initial_city,
    //                         //           decoration: const InputDecoration(
    //                         //               hintText: "Enter City"),
    //                         //         ),
    //                         //         flex: 1,
    //                         //       ),
    //                         //     ],
    //                         //   ),
    //                         // ),
    //                       ],
    //                     ),
    //                   ),
    //                 );
    //               } else {
    //                 return const CircularProgressIndicator();
    //               }
    //             },
    //           ),
    //         ],
    //       ),
    //       Container(
    //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
    //         height: 40,
    //         width: 60,
    //         alignment: Alignment.center,
    //         child: ElevatedButton(
    //           style: ElevatedButton.styleFrom(primary: Colors.purple),
    //           child: const Text(' Update'),
    //           onPressed: () {},
    //         ),
    //       )
    //     ],
    //   ),
    // ));
  }
}
