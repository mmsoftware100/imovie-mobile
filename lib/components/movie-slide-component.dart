import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:imovie/model/video-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:imovie/routes/video-detail-route.dart';
import 'package:provider/provider.dart';

class MovieSlideComponent extends StatefulWidget {
  @override
  _MovieSlideComponentState createState() => _MovieSlideComponentState();
}

class _MovieSlideComponentState extends State<MovieSlideComponent> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _mainSlide();
  }

  Widget _mainSlide(){
    return FutureBuilder(
        future: Provider.of<VideoProvider>(context,listen: true).videoModelListFeatured, //Provider.of<VideoProvider>(context,listen: true).requestVideoModelListFeatured(),
        builder: (BuildContext context, AsyncSnapshot<List<VideoModel>> snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data.length == 0 ) return Container(child: Center(child: Text('no data')),);
            return _carouseSlider(snapshot.data);
          }else if (snapshot.hasError) {
            return Container(child: Center(child: Text('error ${snapshot.error.toString()}')),);
          }
          else{
            return Container(child: Center(child: Text('loading...')),);
          }
        }
    );
  }

  Widget _carouseSlider(List<VideoModel> videoModelList){
    //movies.shuffle();
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        initialPage: videoModelList.length ~/ 2,
        height: MediaQuery.of(context).size.height / 4,
        enableInfiniteScroll: false,
      ),
      items: videoModelList.map((videoModel) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Provider.of<VideoProvider>(context,listen: false).setVideoDetail(videoModel);
                print(jsonEncode(videoModel.toJson()) );
                Navigator.pushNamed(context, VideoDetailRoute.routeName);
                //Navigator.push(context,MaterialPageRoute(builder: (context) => MovieDetailsPage()));
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                    //child: Image.network(videoModel.poster_portrait, fit: BoxFit.fill,)

                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    imageUrl: videoModel.poster_portrait,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                    errorWidget: (context, url, error) => Center(child: CircularProgressIndicator(),),
                  ),


                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

/*

old stack
Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/poster_landscape/2.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator()
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(videoModel.poster_landscape),
                        //image: NetworkImage(videoModel.poster_landscape),
                        //image: AssetImage(videoModel.poster_landscape),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),

                ]
              )
 */
