import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 400,
            width: 200,
            color: Colors.black,
            child: CachedNetworkImage(
              imageUrl: "http://teamworkpk.com/img/AM1506.jpeg",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Office information',
              style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 30),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Team work Est',
              style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 20),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Team work Real Estate,Srinagar',
              style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 20),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Highway,NA-5,near Metro station,G-14',
              style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 20),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Islamabad,Islamabad Capital Territory',
              style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 20),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Pakistan',
              style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 110),
            child: Text(
              'Emergency call',
              style: GoogleFonts.ubuntu(color: Colors.black38, fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.call,
              color: Colors.purple,
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('(+92) 345 8514492'),
                const Text('(+92) 51 5402683')
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.share,
              color: Colors.purple,
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [const Text('Social share:')],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    print('this will work');
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(color: Colors.black12),
                    child: const FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Colors.purple,
                    ),
                    alignment: Alignment.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      print('this will also work');
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(color: Colors.black12),
                      child: const FaIcon(FontAwesomeIcons.whatsapp,
                          color: Colors.purple),
                      alignment: Alignment.center,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Quick Contact',
              style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Expanded(
              child: Text(
                'To get quick, easy access to our properties, simply call us at (+92) 345 8514492. A contact form is on our website if you prefer to reach out to us that way. You can also schedule a showing online by filling out the form below!',
                style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
