
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imovie/components/blurred-container.dart';
import 'package:imovie/model/video-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:imovie/routes/video-detail-route.dart';
import 'package:imovie/style/colors.dart';
import 'package:provider/provider.dart';

class ContinueWatchingCardComponent extends StatelessWidget {
  final VideoModel videoModel;
  ContinueWatchingCardComponent(this.videoModel);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        //  Navigator.pushNamed(context, routeName)
        Provider.of<VideoProvider>(context, listen: false).setVideoDetail(videoModel);
        Navigator.pushNamed(context, VideoDetailRoute.routeName);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        //width: screenWidth / 2.85,
        width: MediaQuery.of(context).size.width / 1.5,
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CachedNetworkImage(

                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width - 100 ,
                  imageUrl: videoModel.poster_portrait,
                  placeholder: (context, url) => Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assets/images/poster_portraits/1.jpg", fit: BoxFit.fill),
                      CircularProgressIndicator(),
                    ],
                  ),
                  errorWidget: (context, url, error) => Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assets/images/poster_portraits/1.jpg", fit: BoxFit.cover,),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: textBackgroundColor,
                      borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(8.0))),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: videoModel.name + '\n',
                          style: Theme.of(context).textTheme.overline,
                        ),
                        TextSpan(
                          text: videoModel?.category?.first?.name ?? '',
                          style: TextStyle(fontSize: 8, color: darkTextColor),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              right: 0.0,
              bottom: 0.0,
              child: BlurredContainer(
                child: Icon(Icons.play_arrow, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*
old
Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      //height: screenWidth / 5.1,
                      //width: screenWidth / 2.85,
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width - 100 ,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/poster_landscape/1.jpg'), fit: BoxFit.cover),
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8.0)),
                          color: Colors.green
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                    Container(
                      //height: screenWidth / 5.1,
                      //width: screenWidth / 2.85,
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width - 100 ,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(videoModel.poster_landscape), fit: BoxFit.cover),
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8.0)),
                          //color: Colors.green
                      ),
                    ),
                  ],
                )

 */
