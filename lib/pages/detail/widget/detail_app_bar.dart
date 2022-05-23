import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../../../models/database.dart';

class DetailAppBar extends StatelessWidget {
  final String id;

  const DetailAppBar({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<DataBase>().fetchListingDetail(id);
    final fetchingList = context.read<DataBase>().fetchListingDetail(id);

    return fetchingList == null
        ? const Center(
            child: const CircularProgressIndicator(),
          )
        : SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Consumer<DataBase>(
                  builder: (context, value, child) {
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
                                scrollDirection: Axis.horizontal,
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
                          height: 20,
                          width: 20,
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                          child: SvgPicture.asset('assets/icons/arrow.svg'),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            shape: BoxShape.circle),
                        child: SvgPicture.asset('assets/icons/mark.svg'),
                      )
                    ],
                  ),
                ))
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
        options: CarouselOptions(
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            initialPage: 0),
        itemBuilder: (BuildContext context, index, ids) {
          if (list[index]['image_link'] == null ||
              list[index]['image_link'] == "") {
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
                  fadeInDuration: const Duration(milliseconds: 1000),
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
