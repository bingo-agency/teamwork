import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_work/models/database.dart';
import 'package:team_work/pages/Property/editProperty.dart';

import '../../widgets/loadingWidgets/verticalListLoading.dart';
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
      // print(fetchAds);
    }

    getList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: id == null
          ? const VerticalListLoading()
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Consumer<DataBase>(
                  builder: (context, value, child) {
                    // print(id);
                    return value.mapAccount.isEmpty && !value.errorAccount
                        ? const VerticalListLoading()
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
                                  if (value.mapAccount['account'][index]
                                          ['message'] ==
                                      "True") {
                                    return AccountCard(
                                        map: value.mapAccount['account']
                                            [index]);
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(value.mapAccount['account']
                                                [index]['message']
                                            .toString()),
                                      ),
                                    );
                                  }
                                },
                              );
                  },
                ),
              ),
            ),
    );
  }
}

class AccountCard extends StatelessWidget {
  AccountCard({Key? key, required this.map}) : super(key: key);

  dynamic map;

  @override
  Widget build(BuildContext context) {
    // print(map.length);
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
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold),
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
                                map['city'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 12),
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
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // var dbclass = await context.read<DataBase>();
                        // print(map.toString());
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditProperty(map: map),
                          ),
                        );
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
                            title: const Text('Warning'),
                            content: const Text(
                                'Are you sure you want to delete this property ?'),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(); // dismisses only the dialog and returns nothing
                                },
                                child: const Text('No'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final dbclass = context.read<DataBase>();
                                  String webPostId = map['id'];
                                  // print('your ' +
                                  //     web_post_id +
                                  //     'has been removed');
                                  var finalres =
                                      await dbclass.removeWebPost(webPostId);
                                  if (finalres == "True" ||
                                      finalres == "[True]") {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ManageAds(id: dbclass.id),
                                      ),
                                    );
                                  } else {
                                    // print(finalres);
                                  }
                                },
                                child: const Text('Yes'),
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
                                  color: Theme.of(context).primaryColor),
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
