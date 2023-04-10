import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/AppState/providers/featuredProvider.dart';
import 'package:team_work/pages/detail/detail.dart';
import 'package:team_work/pages/listing/featuredListing.dart';
import 'package:team_work/widgets/loadingWidgets/featuredLoading.dart';

import '../pages/listing/listing.dart';

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FeaturedProvider>(context, listen: false).getAllFeatured();
    });
    String curl = "?*";
    // context.read<DataBase>().fetchFeatured;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured',
                style: GoogleFonts.ubuntu(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).secondaryHeaderColor),
              ),
              GestureDetector(
                onTap: () {
                  curl = "?feature=yes";
                  print(curl);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FeaturedListing()));
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.ubuntu(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          height: 300,
          child: Consumer<FeaturedProvider>(
            builder: (context, value, child) {
              return value.isLoading
                  ? FeaturedLoading()
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: value.featured.length,
                      itemBuilder: (context, index) {
                        final featured = value.featured;
                        return TempCard(map: featured[index]);
                      },
                    );
            },
          ),
        ),
      ],
    );
  }
}

class TempCard extends StatelessWidget {
  TempCard({Key? key, required this.map}) : super(key: key);
  var map;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print(map);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailPage(id: map.id);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 350,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            CachedNetworkImage(
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: map.primary_image,
                fit: BoxFit.cover,
                width: 350,
                height: 300),
            Positioned(
              right: 15,
              top: 15,
              child: Card(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Featured',
                    style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).backgroundColor),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white54,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            map.title,
                            style: GoogleFonts.ubuntu(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).secondaryHeaderColor),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            map.address,
                            style: GoogleFonts.ubuntu(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).secondaryHeaderColor),
                          ),
                        ],
                      ),
                    ),
                    // CircleIconButton(
                    //     iconUrl: 'assets/icons/mark.svg',
                    //     color: Theme.of(context).primaryColor)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          map.price + ' PKR',
                          style: GoogleFonts.ubuntu(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
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

// class FeaturedCard extends StatelessWidget {
//   FeaturedCard({Key? key, required this.map}) : super(key: key);
//   var map;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         elevation: 10,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Text('this ?'),
//             // Image.network('https://teamworkpk.com/${map['primary_image']}'),
//             Container(
//               width: 230,
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(8)),
//               child: Stack(
//                 children: [
//                   CachedNetworkImage(
//                     progressIndicatorBuilder: (context, url, progress) =>
//                         Center(
//                       child: CircularProgressIndicator(
//                         value: progress.progress,
//                       ),
//                     ),
//                     imageUrl: '${map.primary_image}',
//                   ),
//                   Positioned(
//                     right: 15,
//                     top: 15,
//                     child: CircleIconButton(
//                         iconUrl: 'assets/icons/mark.svg',
//                         color: Theme.of(context).accentColor),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     child: Container(
//                       color: Colors.white54,
//                       padding: const EdgeInsets.all(10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'name',
//                                 style: GoogleFonts.ubuntu(
//                                     fontSize: 16.0,
//                                     fontWeight: FontWeight.bold,
//                                     color:
//                                         Theme.of(context).secondaryHeaderColor),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 'address',
//                                 style: GoogleFonts.ubuntu(
//                                     fontSize: 12.0,
//                                     fontWeight: FontWeight.bold,
//                                     color:
//                                         Theme.of(context).secondaryHeaderColor),
//                               ),
//                             ],
//                           ),
//                           CircleIconButton(
//                               iconUrl: 'assets/icons/mark.svg',
//                               color: Theme.of(context).accentColor)
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
