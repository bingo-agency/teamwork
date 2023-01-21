import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/AppState/providers/projectProvider.dart';
import 'package:team_work/models/database.dart';
import 'package:team_work/pages/detail/projectDetail.dart';
import 'package:team_work/widgets/circle_icon_button.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => new _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProjectProvider>(context, listen: false).getAllProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    // context.read<ProjectProvider>().getAllProjects();
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Projects',
                  style: GoogleFonts.ubuntu(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'View All',
                  style: GoogleFonts.ubuntu(
                      fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 5),
            height: 350,
            child: RefreshIndicator(
              onRefresh: () async {},
              child: Consumer<ProjectProvider>(
                builder: (context, value, child) {
                  return value.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: value.projects.length,
                          itemBuilder: (context, index) {
                            return ProjectsCard(map: value.projects[index]);
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectsCard extends StatelessWidget {
  ProjectsCard({Key? key, required this.map}) : super(key: key);
  var map;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(map);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ProjectDetail(map: map);
        }));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 350,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: map.image_link,
              fit: BoxFit.cover,
              height: 350,
            ),
            Positioned(
              right: 15,
              top: 15,
              child: Card(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    map.ribbon,
                    style: GoogleFonts.ubuntu(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white54,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            map.title,
                            style: GoogleFonts.ubuntu(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            map.address,
                            style: GoogleFonts.ubuntu(
                                fontSize: 12.0, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          map.price + ' PKR',
                          style: GoogleFonts.ubuntu(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
