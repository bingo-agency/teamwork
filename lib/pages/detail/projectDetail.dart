import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:team_work/pages/detail/widget/desc.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'detail.dart';

class ProjectDetail extends StatelessWidget {
  final Map<String, dynamic> map;

  const ProjectDetail({Key? key, required this.map}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Projects'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjCard(map: map),
          ],
        ),
      ),
    );
  }
}

class ProjCard extends StatelessWidget {
  final Map<String, dynamic> map;

  const ProjCard({Key? key, required this.map}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: map['image_link'],
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            // ContentIntro(map: map),
            // const SizedBox(height: 20),
            // HouseInfo(map: map),
            // const SizedBox(height: 20),
            About(
              aboutText: map['description'].toString(),
            ),
            const SizedBox(height: 25),
            Video_tw(
                video: map['video_link'].toString(),
                primaryImage: map['image_link'].toString()),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () async {
                  String telephoneNumber = '+92515402683';
                  String telephoneUrl = "tel:$telephoneNumber";
                  if (await canLaunchUrlString(telephoneUrl)) {
                    await launchUrlString(telephoneUrl);
                  } else {
                    throw "Error occured trying to call that number.";
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  primary: Theme.of(context).primaryColor,
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: const Text(
                    'Contact Now',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
