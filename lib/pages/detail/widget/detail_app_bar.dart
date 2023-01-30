import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../../models/database.dart';

class DetailAppBar extends StatelessWidget {
  final String id;
  final String title;
  final String primaryImage;

  const DetailAppBar(
      {Key? key,
      required this.id,
      required this.title,
      required this.primaryImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<DataBase>().fetchListingDetail(id);
    final fetchingList = context.read<DataBase>().fetchListingDetail(id);

    return fetchingList == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Consumer<DataBase>(
                  builder: (context, value, child) {
                    print('Printing title.');
                    print(fetchingList);
                    return value.mapListingDetail.isEmpty &&
                            !value.errorListingDetail
                        ? const Center(child: CircularProgressIndicator())
                        : value.errorListingDetail
                            ? Text(
                                'Oops, something went wrong .${value.errorMessageListingDetail}',
                                textAlign: TextAlign.center,
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                // scrollDirection: Axis.horizontal,
                                itemCount:
                                    value.mapListingDetail['detail'].length,
                                itemBuilder: (context, index) {
                                  if (value.mapListingDetail.isEmpty ||
                                      value.mapListingDetail == {}) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return CarouselCard(
                                        list: value.mapListingDetail['detail']
                                            [index]['property_images']);
                                  }
                                },
                              );
                  },
                ),
                SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                            child: SvgPicture.asset('assets/icons/arrow.svg'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            String url = 'https://teamworkshare.page.link/';
                            print('share is hit and id is ' + id);
                            final dynamicLinkParams = DynamicLinkParameters(
                              link: Uri.parse(
                                  "https://teamworkpk.com/listing_detail?post_id=" +
                                      id),
                              uriPrefix: url,
                              // link: Uri.parse(url + id),
                              androidParameters: AndroidParameters(
                                packageName: 'com.teamworkpk.teamwork',
                                fallbackUrl: Uri.parse(
                                    'https://play.google.com/store/apps/details?id=com.teamworkpk.teamwork&hl=en&gl=US'),
                                minimumVersion: 0,
                              ),
                              socialMetaTagParameters: SocialMetaTagParameters(
                                title: title,
                                imageUrl: Uri.parse(primaryImage),
                              ),
                            );

                            Uri link = await FirebaseDynamicLinks.instance
                                .buildLink(dynamicLinkParams);

                            final ShortDynamicLink dynamicUrl =
                                await FirebaseDynamicLinks.instance
                                    .buildShortLink(dynamicLinkParams);
                            print('Your link is ' +
                                dynamicUrl.shortUrl.toString());

                            String? desc = dynamicUrl.shortUrl.toString();

                            await Share.share(
                              dynamicUrl.shortUrl.toString(),
                              subject: 'TeamWork Property Exchange',
                            );
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle),
                            child: SvgPicture.asset('assets/icons/share.svg'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class CarouselCard extends StatelessWidget {
  final List<dynamic> list;

  const CarouselCard({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: list.length,
        carouselController: CarouselController(),
        options: CarouselOptions(
            enableInfiniteScroll: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            autoPlay: true,
            enlargeFactor: 0.0,
            scrollDirection: Axis.horizontal,
            viewportFraction: 1.0,
            initialPage: 0),
        itemBuilder: (BuildContext context, index, ids) {
          if (list[index]['image_link'] == null ||
              list[index]['image_link'] == "" ||
              list[index]['image_link'] == '[]' ||
              list[index]['image_link'] == "{}") {
            return const Center(
              child: Text('No images found.'),
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(right: 0.0, top: 0, left: 0),
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) {
                    return const Center(child: CircularProgressIndicator());
                  },
                  imageUrl: list[index]['image_link'].toString(),
                  fit: BoxFit.cover,
                  useOldImageOnUrlChange: false,
                  fadeInDuration: const Duration(milliseconds: 100),
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height / 1.75,
                  // width: MediaQuery.of(context).size.width,

                  // height: double.infinity,
                  // width: double.infinity,
                ),
              ),
            );
          }
          // Text(list[index]['image_link']);
        });
  }
}
