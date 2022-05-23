import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
                                    return SearchCard(
                                        map: value.mapSearch['nonfeatured']
                                            [index]);
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        map['title'],
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            map['address'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12),
                          )
                        ],
                      ),
                    ],
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
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
