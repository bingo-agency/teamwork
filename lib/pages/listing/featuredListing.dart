import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/AppState/providers/featuredProvider.dart';
import 'package:team_work/pages/detail/detail.dart';
import 'package:team_work/widgets/loadingWidgets/verticalListLoading.dart';

class FeaturedListing extends StatelessWidget {
  const FeaturedListing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FeaturedProvider>(context, listen: false).getAllFeatured();
    });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white, // <-- SEE HERE
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Featured Listing",
          style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.background),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Consumer<FeaturedProvider>(
            builder: (context, value, child) {
              return value.isLoading
                  ? const VerticalListLoading()
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.featured.length,
                      itemBuilder: (context, index) {
                        return SearchCard(map: value.featured[index]);
                        // return Text(value.featured[index].id.toString());
                      });
            },
          ),
        ),
      ),
    );
  }
}

class SearchCard extends StatelessWidget {
  var map;
  SearchCard({Key? key, required this.map}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailPage(id: map.id);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 150.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          map.primary_image.toString()),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          map.title,
                          style: GoogleFonts.ubuntu(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).secondaryHeaderColor),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            Expanded(
                              child: Text(
                                map.address,
                                style: GoogleFonts.ubuntu(
                                    fontSize: 12.0,
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  '${map.price} PKR',
                  style: GoogleFonts.ubuntu(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
