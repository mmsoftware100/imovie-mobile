import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imovie/components/blurred-container.dart';
import 'package:imovie/components/category-list-component.dart';
import 'package:imovie/components/continue-watching-component.dart';
import 'package:imovie/components/movie-slide-component.dart';
import 'package:imovie/components/title-row-component.dart';
import 'package:imovie/components/video-list-horizontal-component.dart';
import 'package:imovie/components/year-list-component.dart';
import 'package:imovie/model/category-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:imovie/routes/category-route.dart';
import 'package:imovie/routes/video-detail-route.dart';
import 'package:imovie/routes/year-route.dart';
import 'package:imovie/style/colors.dart';
import 'package:provider/provider.dart';



// data list
List<Video> movies = [
  Video(
    title: 'Video 1',
    genre: 'genre 1',
      image: 'assets/images/poster_landscape/1.jpg',
      image_portrait: 'assets/images/poster_portraits/1.jpg'
  ),
  Video(
    title: 'Video 1',
    genre: 'genre 1',
    image: 'assets/images/poster_landscape/2.jpg',
      image_portrait: 'assets/images/poster_portraits/2.jpg'
  ),
  Video(
    title: 'Video 1',
    genre: 'genre 1',
    image: 'assets/images/poster_landscape/3.jpg',
      image_portrait: 'assets/images/poster_portraits/3.jpg'
  ),
  Video(
      title: 'Video 1',
      genre: 'genre 1',
      image: 'assets/images/poster_landscape/4.jpg',
      image_portrait: 'assets/images/poster_portraits/4.jpg'
  ),
  Video(
    title: 'Video 1',
    genre: 'genre 1',
    image: 'assets/images/poster_landscape/5.jpg',
      image_portrait: 'assets/images/poster_portraits/5.jpg'
  ),Video(
      title: 'Video 1',
      genre: 'genre 1',
      image: 'assets/images/poster_landscape/6.jpg',
      image_portrait: 'assets/images/poster_portraits/6.jpg'
  ),
  Video(
    title: 'Video 1',
    genre: 'genre 1',
    image: 'assets/images/poster_landscape/7.jpg',
      image_portrait: 'assets/images/poster_portraits/7.jpg'
  ),
  Video(
    title: 'Video 1',
    genre: 'genre 1',
    image: 'assets/images/poster_landscape/8.jpg',
      image_portrait: 'assets/images/poster_portraits/8.jpg'
  ),
  Video(
      title: 'Video 1',
      genre: 'genre 1',
      image: 'assets/images/poster_landscape/9.jpg',
      image_portrait: 'assets/images/poster_portraits/9.jpg'
  ),
  Video(
    title: 'Video 1',
    genre: 'genre 1',
    image: 'assets/images/poster_landscape/10.jpg',
      image_portrait: 'assets/images/poster_portraits/10.jpg'
  )
];


class MainComponent extends StatefulWidget {
  @override
  _MainComponentState createState() => _MainComponentState();
}

class _MainComponentState extends State<MainComponent> {

  @override
  Widget build(BuildContext context) {
    return _mainListView();
  }



  Widget _mainListView(){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          MovieSlideComponent(),
          // _carouseSlider(),

          TitleRowComponent('Category List',false),
          Container(
            margin: EdgeInsets.only(left: 8.0),
            //height: 36.0,
            height: 36.0,
            child: CategoryListComponent(),
            //child: ExploreByGenre(width: MediaQuery.of(context).size.width / 4),
          ),

          TitleRowComponent('Year List',false),
          Container(
            margin: EdgeInsets.only(left: 8.0),
            //height: 36.0,
            height: 36.0,
            child: YearListComponent(),
            //child: ExploreByYear(width: MediaQuery.of(context).size.width / 4),
          ),

          TitleRowComponent('Latest Update',true,
            onTap: (){
              print('Latest onTap');
              CategoryModel categoryModel = CategoryModel(0, "Latest Update");
              Provider.of<VideoProvider>(context,listen: false).setCategoryDetail(categoryModel);
              //Provider.of<VideoProvider>(context,listen: false).setCategoryNameDetail(categoryModel);
              //Provider.of<VideoProvider>(context,listen: false).setCategoryDetail(categoryModel);
              //Provider.of<VideoProvider>(context,listen: false).getSeriesList();
              Navigator.pushNamed(context, CategoryRoute.routeName);
            },
          ),
          VideoListHorizontalComponent(Provider.of<VideoProvider>(context,listen: true).videoModelListLatestUpdate),
          //RecentlyAdded('title', 'routeName'),
          //RecentlyAdded('title', 'routeName'),


          TitleRowComponent('Series',true,
            onTap: (){
              print('TV Series onTap');
              Provider.of<VideoProvider>(context,listen: false).setCategoryDetail(CategoryModel(17, "Series"));
              //Provider.of<VideoProvider>(context,listen: false).getSeriesList();
              Navigator.pushNamed(context, CategoryRoute.routeName);
            },
          ),
          VideoListHorizontalComponent(Provider.of<VideoProvider>(context,listen: true).videoModelListByCategoryOneTime[17]),
          //VideoListHorizontalComponent(Provider.of<VideoProvider>(context,listen: true).videoModelListByCategoryOneTime[16]),


          TitleRowComponent('China',true,
            onTap: (){
              print('China Series onTap');
              Provider.of<VideoProvider>(context,listen: false).setCategoryDetail(CategoryModel(11, "China"));
              //Provider.of<VideoProvider>(context,listen: false).getSeriesList();
              Navigator.pushNamed(context, CategoryRoute.routeName);
            },
          ),
          VideoListHorizontalComponent(Provider.of<VideoProvider>(context,listen: true).videoModelListByCategoryOneTime[11]),

          TitleRowComponent('Thai',true,
            onTap: (){
              print('Thai Series onTap');
              Provider.of<VideoProvider>(context,listen: false).setCategoryDetail(CategoryModel(12, "Thai"));
              // Provider.of<VideoProvider>(context,listen: false).getSeriesList();
              Navigator.pushNamed(context, CategoryRoute.routeName);
            },
          ),
          VideoListHorizontalComponent(Provider.of<VideoProvider>(context,listen: true).videoModelListByCategoryOneTime[12]),

          TitleRowComponent('Korea',true,
            onTap: (){
              print('Korea Series onTap');
              Provider.of<VideoProvider>(context,listen: false).setCategoryDetail(CategoryModel(13, "Korea"));
              Provider.of<VideoProvider>(context,listen: false).getSeriesList();
              Navigator.pushNamed(context, CategoryRoute.routeName);
            },
          ),
          VideoListHorizontalComponent(Provider.of<VideoProvider>(context,listen: true).videoModelListByCategoryOneTime[13]),

          TitleRowComponent('India',true,
            onTap: (){
              print('India Series onTap');
              Provider.of<VideoProvider>(context,listen: false).setCategoryDetail(CategoryModel(14, "India"));
              Provider.of<VideoProvider>(context,listen: false).getSeriesList();
              Navigator.pushNamed(context, CategoryRoute.routeName);
            },
          ),
          VideoListHorizontalComponent(Provider.of<VideoProvider>(context,listen: true).videoModelListByCategoryOneTime[14]),

          TitleRowComponent('Cartoon',true,
            onTap: (){
              print('Cartoon Series onTap');
              Provider.of<VideoProvider>(context,listen: false).setCategoryDetail(CategoryModel(15, "Cartoon"));
              Provider.of<VideoProvider>(context,listen: false).getSeriesList();
              Navigator.pushNamed(context, CategoryRoute.routeName);
            },
          ),
          VideoListHorizontalComponent(Provider.of<VideoProvider>(context,listen: true).videoModelListByCategoryOneTime[15]),
          //RecentlyAdded('title', 'routeName'),

          /*
          TitleRowComponent('Featured',false,onTap: (){ print('watch list onTap');Navigator.pushNamed(context, CategoryRoute.routeName);},),
          ContinueWatchingComponent(),

           */


          TitleRowComponent('Others',true,
            onTap: (){
              print('Others onTap');

              Provider.of<VideoProvider>(context,listen: false).setCategoryDetail(CategoryModel(16, "Others"));
              Provider.of<VideoProvider>(context,listen: false).getSeriesList(); // clear
              Navigator.pushNamed(context, CategoryRoute.routeName);
              /*

              Provider.of<VideoProvider>(context,listen: false).setCategoryNameDetail(CategoryModel(16, "Others"));
              Provider.of<VideoProvider>(context,listen: false).getMovieList();
              Navigator.pushNamed(context, CategoryRoute.routeName);

               */
            },
          ),
          VideoListHorizontalComponent(Provider.of<VideoProvider>(context,listen: true).videoModelListByCategoryOneTime[16]),

          //ContinueWatching('test')
          SizedBox(height: 100,)

        ],
      ),
    );
  }



}


class Video {
  final String image;
  final String image_portrait;
  final String title;
  final String genre;
  final String language;
  final int noOfEpisodes;
  final int noOfSeasons;

  Video({
    this.image,
    this.image_portrait,
    this.title,
    this.genre,
    this.language,
    this.noOfEpisodes,
    this.noOfSeasons,
  });
}

class VideoClip {
  final String thumbnail;
  final String time;

  VideoClip(this.thumbnail, this.time);
}



class TitleRow extends StatelessWidget {
  final String title;
  final bool showIcon;
  final Widget button;
  final Function onTap;

  TitleRow(this.title, this.showIcon, {this.button, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.caption,
            ),
            showIcon
                ? Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16.0,
            )
                : button ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}


class ContinueWatching extends StatelessWidget {
  final String routeName;

  ContinueWatching(this.routeName);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.0),
      height: MediaQuery.of(context).size.height / 4,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: movies.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Hero(
              tag: index,
              child: ContinueWatchingCard(movies[index], routeName));
        },
      ),
    );
  }
}

class ContinueWatchingCard extends StatelessWidget {
  final Video movieIndex;
  final String routeName;

  ContinueWatchingCard(this.movieIndex, this.routeName);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
       //  Navigator.pushNamed(context, routeName)
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
                Container(
                  //height: screenWidth / 5.1,
                  //width: screenWidth / 2.85,
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width - 100 ,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(movieIndex.image), fit: BoxFit.cover),
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(8.0)),
                    color: Colors.green
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
                          text: movieIndex.title + '\n',
                          style: Theme.of(context).textTheme.overline,
                        ),
                        TextSpan(
                          text: movieIndex.genre,
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

class Genre {
  final String genre;
  final Color color;

  Genre(this.genre, this.color);
}

class ExploreByGenre extends StatelessWidget {
  final double width;

  ExploreByGenre({this.width});

  @override
  Widget build(BuildContext context) {
    List<Genre> genres = [
      Genre('Action', Colors.blue),
      Genre('Adventure', Colors.red),
      Genre('Comedy', Colors.yellow.shade800),
      Genre('Drama', Colors.green),
      Genre('Horror', Colors.deepPurple),
    ];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: genres.length,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, CategoryRoute.routeName);
            //=> Navigator.pushNamed(context, PageRoutes.movieDetailsPage
          },
          child: Container(
            margin: EdgeInsets.only(left: 8.0),
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: genres[index].color,
            ),
            padding: EdgeInsets.all(8.0),
            child: Center(
                child: Text(
                  genres[index].genre.toUpperCase(),
                  style: Theme.of(context).textTheme.caption,
                )),
          ),
        );
      },
    );
  }
}

class YearModel{
  final int year;
  final Color color;
  YearModel(this.year, this.color);
}

class ExploreByYear extends StatelessWidget {
  final double width;

  ExploreByYear({this.width});

  @override
  Widget build(BuildContext context) {
    List<YearModel> years = [];
    List colors = [Colors.red, Colors.green,Colors.orange, Colors.grey, Colors.blue];
    final Random random = new Random();
    for(int i = 2021; i > 1969; i--){
      ///print('year is $i');
      years.add(YearModel(i, colors[random.nextInt(colors.length - 1)] ));
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: years.length,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, YearRoute.routeName);
            //=> Navigator.pushNamed(context, PageRoutes.movieDetailsPage
          },
          child: Container(
            margin: EdgeInsets.only(left: 8.0),
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: years[index].color,
            ),
            padding: EdgeInsets.all(8.0),
            child: Center(
                child: Text(
                  years[index].year.toString(),
                  style: Theme.of(context).textTheme.caption,
                )),
          ),
        );
      },
    );
  }
}



class RecentlyAdded extends StatelessWidget {
  final String title;
  final String routeName;

  RecentlyAdded(this.title, this.routeName);

  @override
  Widget build(BuildContext context) {
    List<Video> movies_shuffle = movies.toList();
    movies_shuffle.shuffle();
    movies.shuffle();
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 8.0),
      //height: screenWidth / 3,
      height: MediaQuery.of(context).size.height / 5,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: movies_shuffle.length,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ThumbTile(movies_shuffle[index], routeName);
          }),
    );
  }
}


class ThumbTile extends StatelessWidget {
  final Video videoIndex;
  final String routeName;

  ThumbTile(this.videoIndex, this.routeName);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 8.0),
        //height: screenWidth / 3,
        //width: screenWidth / 4.25,
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.height / 7,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(videoIndex.image_portrait), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onTap: () => Navigator.pushNamed(context, VideoDetailRoute.routeName),
    );
  }
}
