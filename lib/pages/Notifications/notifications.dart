import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/noRecordsFound.dart';

class Notifications extends StatelessWidget {
  String id;
  Notifications({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: const BackButton(color: Colors.white),
        title: Text('Notifications',
            style: GoogleFonts.ubuntu(color: Colors.white)),
      ),
      body: Center(
        child: noRecordsFound(context, "You don't have any Notifications yet."),
      ),
    );
  }
}
