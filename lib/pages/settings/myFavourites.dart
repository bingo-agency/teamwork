import 'package:flutter/material.dart';

class myFavourites extends StatelessWidget {
  String id;
  myFavourites({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('myFavourites'),
      ),
    );
  }
}
