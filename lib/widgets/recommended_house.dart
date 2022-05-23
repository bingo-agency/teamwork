import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_work/models/database.dart';
import 'package:team_work/models/house.dart';
import 'package:team_work/pages/detail/detail.dart';
import 'package:team_work/widgets/circle_icon_button.dart';

import '../pages/listing/listing.dart';

class RecommendedHouse extends StatelessWidget {
  const RecommendedHouse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String curl = "?*";
    context.read<DataBase>().fetchFeatured;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  curl = "?feature=yes";
                  print(curl);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ListingPage(curl: curl)));
                },
                child: Text(
                  'View All',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          height: 350,
          child: RefreshIndicator(
            onRefresh: () async {},
            child: Consumer<DataBase>(
              builder: (context, value, child) {
                return value.mapFeatured.isEmpty && !value.errorFeatured
                    ? const Center(child: CircularProgressIndicator())
                    : value.errorFeatured
                        ? Text(
                            'Oops, something went wrong .${value.errorMessageFeatured}',
                            textAlign: TextAlign.center,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: value.mapFeatured['featured'].length,
                            itemBuilder: (context, index) {
                              return TempCard(
                                  map: value.mapFeatured['featured'][index]);
                            },
                          );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class TempCard extends StatelessWidget {
  const TempCard({Key? key, required this.map}) : super(key: key);
  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print(map);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailPage(map: map);
            },
          ),
        );
      },
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(10),
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
                imageUrl: map['primary_image'],
                fit: BoxFit.cover,
                width: 350,
                height: 350),
            Positioned(
              right: 15,
              top: 15,
              child: Card(
                color: Theme.of(context).primaryColor,
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Featured',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
                          Text(map['title'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            map['address'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    // CircleIconButton(
                    //     iconUrl: 'assets/icons/mark.svg',
                    //     color: Theme.of(context).primaryColor)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          map['price'] + ' PKR',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple),
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

class FeaturedCard extends StatelessWidget {
  const FeaturedCard({Key? key, required this.map}) : super(key: key);
  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('this ?'),
            // Image.network('https://teamworkpk.com/${map['primary_image']}'),
            Container(
              width: 230,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    imageUrl: '${map['primary_image']}',
                  ),
                  Positioned(
                    right: 15,
                    top: 15,
                    child: CircleIconButton(
                        iconUrl: 'assets/icons/mark.svg',
                        color: Theme.of(context).accentColor),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'name',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'address',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          CircleIconButton(
                              iconUrl: 'assets/icons/mark.svg',
                              color: Theme.of(context).accentColor)
                        ],
                      ),
                    ),
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
