import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Page5 extends StatefulWidget {
  @override
  _Page5State createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40.0),
                Row(
                  children: [
                    Text("Como usar o Ziit?",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Card(
                elevation: 10,
                color: Colors.white,
                child: Container(
                  height: 220,
                  child: Center(
                    child: YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId: 'e-2dmgMSZE4', //Add videoID.
                        flags: YoutubePlayerFlags(
                          hideControls: false,
                          controlsVisibleAtStart: false,
                          autoPlay: true,
                          mute: false,
                        ),
                      ),
                      showVideoProgressIndicator: true,
                      // progressIndicatorColor: AppColors.primary,
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40.0),
                Center(
                  child: Text("Para mais informações acesse:\n www.zit.net.br",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xffCCFF00),
                          fontSize: 14,
                          fontWeight: FontWeight.w300)),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
