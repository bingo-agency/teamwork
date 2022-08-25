import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/database.dart';
import '../../widgets/best_offer.dart';
import '../detail/detail.dart';

class ListingPage extends StatelessWidget {
  final String curl;

  const ListingPage({Key? key, required this.curl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchCurl = context.read<DataBase>().Search(curl);
    print(searchCurl);
    Future getList() async {
      searchCurl;
      print(searchCurl);
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple),
      body: searchCurl == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: RefreshIndicator(
                  onRefresh: () async {
                    getList;
                  },
                  child: Consumer<DataBase>(
                    builder: (context, value, child) {
                      print(curl);
                      return value.mapSearch.isEmpty && !value.errorSearch
                          ? const Center(child: CircularProgressIndicator())
                          : value.errorSearch
                              ? Text(
                                  'Oops, something went wrong .${value.errorMessageSearch}',
                                  textAlign: TextAlign.center,
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      value.mapSearch['nonfeatured'].length,
                                  itemBuilder: (context, index) {
                                    if (value.mapSearch['nonfeatured'][0]
                                            ['msg'] !=
                                        'True') {
                                      return Center(
                                        child: Container(
                                          width: double.infinity,
                                          height: 500,
                                          alignment: Alignment.center,
                                          padding:
                                              const EdgeInsets.only(top: 200),
                                          child: Text(value
                                              .mapSearch['nonfeatured'][0]
                                                  ['msg']
                                              .toString()),
                                        ),
                                      );
                                    } else {
                                      return SearchCard(
                                          map: value.mapSearch['nonfeatured']
                                              [index]);
                                    }
                                  },
                                );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}

class SearchCard extends StatelessWidget {
  const SearchCard({Key? key, required this.map}) : super(key: key);

  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    print(map.length);
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
                      image: CachedNetworkImageProvider(map['primary_image']),
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
                          map['title'],
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
                                map['address'],
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
                  map['price'] + ' PKR',
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
