import 'package:flutter/material.dart';

class SavedSearch extends StatelessWidget {
  String id;
  SavedSearch({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Saved Searches$id'),
      ),
    );
  }
}
