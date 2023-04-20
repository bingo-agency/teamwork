import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HouseInfo extends StatelessWidget {
  var id;
  var type;
  var internal_lead_id;
  var land_area;
  var property_type;

  HouseInfo({
    Key? key,
    required this.id,
    required this.type,
    required this.internal_lead_id,
    required this.land_area,
    required this.property_type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              MenuInfo(imageUrl: 'assets/icons/hashtag.svg', content: id),
              MenuInfo(imageUrl: 'assets/icons/plot.svg', content: type),
              MenuInfo(
                  imageUrl: 'assets/icons/home.svg', content: internal_lead_id),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const MenuInfo(imageUrl: 'assets/icons/parking.svg', content: 'Yes'),
              MenuInfo(
                  imageUrl: 'assets/icons/shape24.svg', content: land_area),
              MenuInfo(
                  imageUrl: 'assets/icons/more.svg', content: property_type),
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
            const SizedBox(width: 20),
            Text(
              content,
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
