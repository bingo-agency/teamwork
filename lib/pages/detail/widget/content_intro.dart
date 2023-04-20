import 'package:flutter/material.dart';

class ContentIntro extends StatelessWidget {
  String title;
  String type;
  String price;

  ContentIntro({
    Key? key,
    required this.title,
    required this.type,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          // Text(
          //   map.status.toString(),
          //   style:
          //       Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
          // ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Type  ',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                type,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: price,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
                TextSpan(
                  text: ' PKR',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
