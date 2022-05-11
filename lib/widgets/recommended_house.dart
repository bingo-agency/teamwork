import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_work/models/featured_home.dart';
import 'package:team_work/models/house.dart';
import 'package:team_work/pages/detail/detail.dart';
import 'package:team_work/widgets/circle_icon_button.dart';

//
class RecommendedHouse extends StatelessWidget {
  final recommendedList = House.generateRecommended();
  @override
  Widget build(BuildContext context) {
    context.read<FeaturedHome>().fetchData;
    return Container(
      padding: EdgeInsets.all(15),
      height: 340,
      child: RefreshIndicator(
        onRefresh: () async {},
        child: Consumer<FeaturedHome>(
          builder: (context, value, child) {
            return value.map.length == 0 && !value.error
                ? CircularProgressIndicator()
                : value.error
                    ? Text(
                        'Oops, something went wrong .${value.errorMessage}',
                        textAlign: TextAlign.center,
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.map['web_posts'].length,
                        itemBuilder: (context, index) {
                          return TempCard(map: value.map['web_posts'][index]);
                        },
                      );
          },
        ),
      ),
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
        print(map);
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) {
        //   return DetailPage(house: map);
        // }));
      },
      child: Container(
        width: 230,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        map['primary_image'],
                      ),
                      fit: BoxFit.cover)),
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
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(map['title'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            map['address'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      CircleIconButton(
                          iconUrl: 'assets/icons/mark.svg',
                          color: Theme.of(context).accentColor)
                    ],
                  ),
                ))
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
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Stack(
                children: [
                  Container(
                    child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                      imageUrl:
                          'https://teamworkpk.com/${map['primary_image']}',
                    ),
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
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('name',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                SizedBox(
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
                                )
                              ],
                            ),
                            CircleIconButton(
                                iconUrl: 'assets/icons/mark.svg',
                                color: Theme.of(context).accentColor)
                          ],
                        ),
                      ))
                ],
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}
