import 'package:flutter/material.dart';

class PropertyType extends StatelessWidget {
  const PropertyType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border(bottom: BorderSide())),
        child: Text(
          'categoriesList[index]',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16,
          ),
        ));
  }
}
