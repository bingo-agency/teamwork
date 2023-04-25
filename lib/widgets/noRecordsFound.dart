import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

noRecordsFound(context, msg) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height / 3.0,
      ),
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
    ],
  );
}
