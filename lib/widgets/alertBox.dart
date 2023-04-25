import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void alertBox(context, msg) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Warning',
            style: GoogleFonts.ubuntu(color: Theme.of(context).primaryColor),
          ),
          content: Text(msg, style: GoogleFonts.ubuntu()),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            )
          ],
        );
      });
}
