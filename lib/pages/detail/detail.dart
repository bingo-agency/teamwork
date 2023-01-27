import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/AppState/providers/detailsProvider.dart';
import 'package:team_work/pages/detail/widget/content_intro.dart';
import 'package:team_work/pages/detail/widget/desc.dart';
import 'package:team_work/pages/detail/widget/detail_app_bar.dart';
import 'package:team_work/pages/detail/widget/house_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../models/database.dart';
import '../../widgets/loadingWidgets/detailLoading.dart';

class DetailPage extends StatefulWidget {
  var map;
  DetailPage({Key? key, required this.map}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DetailsProvider>(context, listen: false)
          .getDetails(widget.map.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailsProvider>(
        builder: (context, value, child) {
          return value.isLoading
              ? DetailLoading()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DetailAppBar(id: widget.map.id.toString()),
                      const SizedBox(height: 20),
                      ContentIntro(map: widget.map),
                      const SizedBox(height: 20),
                      HouseInfo(map: widget.map),
                      const SizedBox(height: 20),
                      About(
                        aboutText: widget.map.description.toString(),
                      ),
                      const SizedBox(height: 25),
                      Video_tw(
                          video: widget.map.video_link.toString(),
                          primaryImage: widget.map.primary_image.toString()),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: WebView(
                              initialUrl:
                                  'https://teamworkpk.com/API/mapview?address=' +
                                      widget.map.address.toString() +
                                      '&city=' +
                                      widget.map.city.toString(),
                              javascriptMode: JavascriptMode.unrestricted,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            String telephoneNumber = '+92515402683';
                            String telephoneUrl = "tel:$telephoneNumber";
                            if (await canLaunch(telephoneUrl)) {
                              await launch(telephoneUrl);
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
                            child: Text(
                              'Contact Now',
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class Video_tw extends StatelessWidget {
  final String video;
  final String primaryImage;

  const Video_tw({Key? key, required this.video, required this.primaryImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? vid;
    vid = YoutubePlayer.convertUrlToId(video.toString());
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: vid.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        disableDragSeek: true,
      ),
    );

    if (video.isEmpty || video.toString() == 'null') {
      return Container();
    } else {
      return YoutubePlayerBuilder(
          player: YoutubePlayer(
            thumbnail: CachedNetworkImage(
              imageUrl: primaryImage,
              fit: BoxFit.cover,
            ),
            controller: _controller,
          ),
          builder: (context, player) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    'Video',
                    style: GoogleFonts.ubuntu(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: player,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                //some other widgets
              ],
            );
          });
    }
  }
}
