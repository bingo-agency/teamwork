import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/listing/listing.dart';

noRecordsFound(context, msg) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.search_off,
        size: 50,
        color: Theme.of(context).primaryColor,
      ),
      const SizedBox(height: 10),
      Text(
        msg,
        style: GoogleFonts.ubuntu(
          fontSize: 20,
          color: Theme.of(context).primaryColor,
        ),
      ),
      const SizedBox(height: 10.0),
      ElevatedButton(
          onPressed: () {
            String curl = '?*';
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => ListingPage(curl: curl),
              ),
            );
          },
          child: const Text('Go to Property Listing'))
    ],
  );
}
