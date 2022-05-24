import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_work/models/database.dart';

import '../detail/detail.dart';

class ManageAds extends StatelessWidget {
  // final Map<String, dynamic> map;
  final String id;

  const ManageAds({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fetchAds = context.read<DataBase>().fetchAccount(id);
    // print(fetchAds);

    Future getList() async {
      await fetchAds;
      print(fetchAds);
    }

    getList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: id == null
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
                      print(id);
                      return value.mapAccount.isEmpty && !value.errorAccount
                          ? const Center(child: CircularProgressIndicator())
                          : value.errorAccount
                              ? Text(
                                  'Oops, something went wrong .${value.errorMessageAccount}',
                                  textAlign: TextAlign.center,
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: value.mapAccount['account'].length,
                                  itemBuilder: (context, index) {
                                    return AccountCard(
                                        map: value.mapAccount['account']
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

class AccountCard extends StatelessWidget {
  const AccountCard({Key? key, required this.map}) : super(key: key);

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
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('this was hit !');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Edit',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Warning'),
                            content: Text(
                                'Are you sure you want to delete this property ?'),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(); // dismisses only the dialog and returns nothing
                                },
                                child: Text('No'),
                              ),
                              FlatButton(
                                onPressed: () {
                                  print(
                                      'delete this here and notify the fucking listeneres');
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          ' Remove',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
