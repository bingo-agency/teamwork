import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/AppState/providers/listingProvider.dart';
import 'package:team_work/widgets/loadingWidgets/verticalListLoading.dart';

import '../../models/database.dart';
import '../../widgets/best_offer.dart';
import '../detail/detail.dart';

class ListingPage extends StatefulWidget {
  final String curl;
  ListingPage({Key? key, required this.curl}) : super(key: key);
  @override
  ListingPageState createState() => ListingPageState();
}

class ListingPageState extends State<ListingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ListingProvider>(context, listen: false)
          .getAllListing(widget.curl);
    });
    //here ?
  }

  @override
  Widget build(BuildContext context) {
    final searchCurl = context.read<DataBase>().Search(widget.curl);
    print(searchCurl);
    Future getList() async {
      searchCurl;
      print(searchCurl);
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).primaryColor),
      body: SingleChildScrollView(
        child: Consumer<ListingProvider>(
          builder: (context, value, child) {
            print(widget.curl);
            return value.isLoading
                ? VerticalListLoading()
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: value.listing.length,
                    itemBuilder: (context, index) {
                      return SearchCard(map: value.listing[index]);
                      // return Text(value.listing.length.toString());
                    });
          },
        ),
      ),
    );
  }
}

class SearchCard extends StatelessWidget {
  SearchCard({Key? key, required this.map}) : super(key: key);

  var map;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailPage(map: map);
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
                      image: CachedNetworkImageProvider(map.primary_image),
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
                  map.price + ' PKR',
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
