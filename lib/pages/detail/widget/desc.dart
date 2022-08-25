import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  final String aboutText;

  const About({Key? key, required this.aboutText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'About',
            style:
                GoogleFonts.ubuntu(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            aboutText,
            style:
                GoogleFonts.ubuntu(fontSize: 14.0, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
