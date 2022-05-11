import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_work/AppState.dart';

class WelcomeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'homeTitle',
          ),
          // Consumer<AppState>(builder: (context, value, child) {
          //   Future.delayed(Duration.zero, () {
          //     value.setDisplayText('hello Khurshid');
          //   });
          //   return Text(
          //     '${value.hometitle}',
          //   );
          // }),
          SizedBox(height: 10),
          Text(
            'Find your sweet Home',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
