import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HouseInfo extends StatelessWidget {
  final Map<String, dynamic> map;

  const HouseInfo({Key? key, required this.map}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              MenuInfo(
                  imageUrl: 'assets/icons/hashtag.svg',
                  content: map['id'].toString()),
              MenuInfo(
                  imageUrl: 'assets/icons/plot.svg',
                  content: map['type'].toString()),
              MenuInfo(
                  imageUrl: 'assets/icons/home.svg',
                  content: map['internal_lead_id'].toString()),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              MenuInfo(imageUrl: 'assets/icons/parking.svg', content: 'Yes'),
              MenuInfo(
                  imageUrl: 'assets/icons/shape24.svg',
                  content: map['land_area'].toString()),
              MenuInfo(
                  imageUrl: 'assets/icons/more.svg',
                  content: map['property_type']),
            ],
          )
        ],
      ),
    );
  }
}

class MenuInfo extends StatelessWidget {
  final String imageUrl;
  final String content;

  const MenuInfo({Key? key, required this.imageUrl, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Row(
          children: [
            SvgPicture.asset(imageUrl, width: 20),
            SizedBox(width: 20),
            Text(
              content,
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
