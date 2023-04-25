import 'package:flutter/material.dart';

class Drafts extends StatelessWidget {
  String id;
  Drafts({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Drafts$id'),
      ),
    );
  }
}
