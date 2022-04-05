

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:imovie/data/const-data.dart';
import 'package:imovie/model/category-model.dart';
import 'package:imovie/model/episode-model.dart';
import 'package:imovie/model/file-model.dart';
import 'package:imovie/model/resolution-model.dart';
import 'package:imovie/model/user-model.dart';
import 'package:imovie/model/video-model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VideoProvider extends ChangeNotifier{
  List<VideoModel> videoModelListFeaturedNormal;
  Future<List<VideoModel>> videoModelListFeatured;

  List<VideoModel> videoModelListLatestUpdateNormal;
  Future<List<VideoModel>> videoModelListLatestUpdate;

  List<VideoModel> videoModelListMovieNormal;
  Future<List<VideoModel>> videoModelListMovie;

  List<VideoModel> videoModelListSeriesNormal;
  Future<List<VideoModel>> videoModelListSeries;

  List<VideoModel> videoModelListSearchNormal;
  Future<List<VideoModel>> videoModelListSearch;


  List<VideoModel> videoModelListCategoryNormal;
  Future<List<VideoModel>> videoModelListCategory;

  List<VideoModel> videoModelListYearNormal;
  Future<List<VideoModel>> videoModelListYear;

  List<CategoryModel> categoryModelListNormal;
  Future<List<CategoryModel>> categoryModelList;

  //Map<int, List<VideoModel>> videoModelListByCategoryOneTimeNormal;
  Map<int, Future<List<VideoModel>>> videoModelListByCategoryOneTime = {
    11: null,
    12: null,
    13: null,
    14: null,
    15: null
  };
  //Future<Future<Map<int, List<VideoModel>>>> videoModelListByCategoryOneTime;
  //Future<Map<int, List<VideoModel>>> videoModelListByCategoryOneTime;

  VideoModel detailVideoModel;
  CategoryModel detailCategoryModel = CategoryModel(0, "Video List");
  FileModel detailFileModel;
  String file_download_url;
  int detailYear;

  UserModel userModel;

  int point = 0;

  String localVideoPath = "";

  void setLocalVideoPath(String path){
    print("VideoProvider->setLocalVideoPath $path");
    localVideoPath = path;
    notifyListeners();
  }

  Future<void> setPoint(int newPoint) async{
    point = newPoint;
    SharedPreferences sP = await SharedPreferences.getInstance();
    sP.setInt("point", point);
    notifyListeners();
  }
  Future<int> getPoint() async{
    SharedPreferences sP = await SharedPreferences.getInstance();
    int newPoint = sP.getInt("point") ?? 10000;
    point = newPoint;
    notifyListeners();
    return point;
  }




  //final String apiHost = 'https://mmsoftware100.com/';
  //final String apiEndpointCategory = 'imovie/api/v1/video/select_by_category/index.php';
  //final String apiEndpointLatest = 'https://mmsoftware100.com/imovie/api/v1/video/select_by_type/index.php';
  //final String apiEndpointSearch = 'https://mmsoftware100.com/imovie/api/v1/video/search/index.php';
  //final String apiEndpointYear = 'https://mmsoftware100.com/imovie/api/v1/video/select_by_release_year/index.php';
  //final String apiEndpointCategorySelect = 'https://mmsoftware100.com/imovie/api/v1/category/select/index.php';
  //final String apiEndpointFileModelSelect = 'https://mmsoftware100.com/imovie/api/v1/video/select_file_url/index.php';

  VideoProvider(){
    // detailVideoModel = _makeVideoModelForTvSeries();
    //detailVideoModel = _makeVideoModelForMovie();
  }
  Future<UserModel> userLogin(String name, String password)async{
    try{
      var body = {
        'name':name,
        'password':password
      };
      print("VideoProvider->userLogin try");
      print(body);

      var response =  await http.post(apiEndpointUserLogin,body:body);

      print("VideoProvider->userLogin response");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map<String, dynamic> dataResponse = jsonDecode(response.body);
      dynamic dataList =  dataResponse['data'];  // list of wp-content

        try{
          userModel = UserModel.fromJson(dataList);
        }catch(innerExp){
          print('VideoProvider->userLogin innerExp $innerExp');
          userModel = null;
        }

      //notifyListeners();
      return userModel;
    }catch(exp){
      print('VideoProvider->userLogin exp');
      userModel = null;
      print(exp);
      return userModel;
    }
  }


  Future<void> requestVideoModelListCategoryOneTime(int categoryId)async{
    try{
      var body = {
        'category':categoryId.toString(),
        'last_id':'0',
        'limit':'100'
      };
      var response =  await http.post(apiEndpointCategory,body:body);

      print("VideoProvider->requestVideoModelListCategoryOneTime response $categoryId");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map<String, dynamic> dataResponse = jsonDecode(response.body);
      List<dynamic> dataList =  dataResponse['data'];  // list of wp-content
      //wpContentList = [];
      List<VideoModel> videoModelList = [];
      for(int i=0; i<dataList.length; i++){

        try{
          videoModelList.add(VideoModel.fromJson(dataList[i]));
        }catch(innerExp){
          print('VideoProvider->requestVideoModelListCategoryOneTime innerExp $innerExp');
        }

      }
      // this is normal video list with key int
      Future<List<VideoModel>> videoModelListFuture = Future.delayed(Duration.zero,()=>videoModelList);
      videoModelListByCategoryOneTime[categoryId] = videoModelListFuture;
      notifyListeners();
      //return featuredVideoModelList;
    }catch(exp){
      print('VideoProvider->requestVideoModelListCategory exp');
      print(exp);
      //return Future.delayed(Duration.zero,()=>null);
    }
  }

  // ဒါဟာ categroy တစ်မျိုးပါပဲ
  Future<void> requestVideoModelListFeatured()async{
    print('requestVideoModelListFeatured ');
    print(apiEndpointCategory);
    try{
      var body = {
        'category':'2', // 2 means featured
        'last_id':'0',
        'limit':'100'
      };
      var response =  await http.post(apiEndpointCategory,body:body);

      print("VideoProvider->requestVideoModelListFeatured response");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map<String, dynamic> dataResponse = jsonDecode(response.body);
      List<dynamic> dataList =  dataResponse['data'];  // list of wp-content
      //wpContentList = [];
      for(int i=0; i<dataList.length; i++){
        if(videoModelListFeaturedNormal == null){
          videoModelListFeaturedNormal = [];
        }
        print('dataList[i]');
        print(jsonEncode(dataList[i]));
        try{
          videoModelListFeaturedNormal.add(VideoModel.fromJson(dataList[i]));
        }catch(innerExp){
          print('VideoProvider->requestVideoModelListFeatured innerExp $innerExp');
        }

      }

      videoModelListFeatured = Future.delayed(Duration.zero,()=>videoModelListFeaturedNormal);
      notifyListeners();
      //return featuredVideoModelList;
    }catch(exp){
      print('VideoProvider->requestVideoModelListFeatured exp');
      print(exp);
      //return Future.delayed(Duration.zero,()=>null);
    }
  }
  // ဒါလည်း အတူတူပဲ customize category ဖြစ်သွားတာပေါ့ ။ home page အတွက်လည်း အမျိုးမျိုး ခွဲတောင်းမယ်၊ တစ်ခုချင်းအတွက်လည်း သီးသန့်တောင်းမယ်
  Future<void> requestVideoModelListCategory(int categoryId)async{
    try{
      var body = {
        'category':categoryId.toString(),
        'last_id':'0',
        'limit':'100'
      };
      print(body);
      String endPoint = apiEndpointCategory;
      print(endPoint);
      if(categoryId.toString() == "0") endPoint = apiEndpointLatest;

      var response =  await http.post(endPoint,body:body);

      print("VideoProvider->requestVideoModelListCategory response $categoryId");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map<String, dynamic> dataResponse = jsonDecode(response.body);
      List<dynamic> dataList =  dataResponse['data'];  // list of wp-content
      //wpContentList = [];
      videoModelListCategoryNormal = [];
      for(int i=0; i<dataList.length; i++){
        if(videoModelListCategoryNormal == null){
          videoModelListCategoryNormal = [];
        }
        try{
          videoModelListCategoryNormal.add(VideoModel.fromJson(dataList[i]));
        }catch(innerExp){
          print('VideoProvider->requestVideoModelListCategory innerExp $innerExp');
        }

      }
      videoModelListCategoryNormal.forEach((element) {
        //print(element.toJson());
        //log(element.toJson().toString());
      });
      videoModelListCategory = Future.delayed(Duration.zero,()=>videoModelListCategoryNormal);
      notifyListeners();
      //return featuredVideoModelList;
    }catch(exp){
      print('VideoProvider->requestVideoModelListCategory exp');
      print(exp);
      //return Future.delayed(Duration.zero,()=>null);
    }
  }
  // ဒါကတော့ ခုနှစ် အလိုက် တောင်းမှာ
  Future<void> requestVideoModelListYear(int year)async{
    try{
      var body = {
        'releaseyear':year.toString(),
        'last_id':'0',
        'limit':'100'
      };
      var response =  await http.post(apiEndpointYear,body:body);

      print("VideoProvider->requestVideoModelListYear response");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map<String, dynamic> dataResponse = jsonDecode(response.body);
      List<dynamic> dataList =  dataResponse['data'];  // list of wp-content
      //wpContentList = [];
      for(int i=0; i<dataList.length; i++){
        if(videoModelListYearNormal == null){
          videoModelListYearNormal = [];
        }
        try{
          videoModelListYearNormal.add(VideoModel.fromJson(dataList[i]));
        }catch(innerExp){
          print('VideoProvider->requestVideoModelListYear innerExp $innerExp');
        }

      }
      videoModelListYearNormal.forEach((element) {
        //print(element.toJson());
        //log(element.toJson().toString());
      });
      videoModelListYear = Future.delayed(Duration.zero,()=>videoModelListYearNormal);
      notifyListeners();
      //return featuredVideoModelList;
    }catch(exp){
      print('VideoProvider->requestVideoModelListYear exp');
      print(exp);
      //return Future.delayed(Duration.zero,()=>null);
    }
  }
  // ဒါက search view အတွက် 
  Future<void> requestVideoModelListSearch(String search)async{

    try{

      videoModelListSearchNormal = [];
      videoModelListSearch = Future.delayed(Duration.zero,()=>videoModelListSearchNormal);
      notifyListeners();

      var body = {
        'name':search,
        'last_id':'0',
        'limit':'100'
      };
      var response =  await http.post(apiEndpointSearch,body:body);

      print("VideoProvider->requestVideoModelListSearch response");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map<String, dynamic> dataResponse = jsonDecode(response.body);
      List<dynamic> dataList =  dataResponse['data'];  // list of wp-content
      //wpContentList = [];
      for(int i=0; i<dataList.length; i++){
        try{
          videoModelListSearchNormal.add(VideoModel.fromJson(dataList[i]));
        }catch(innerExp){
          print('VideoProvider->requestVideoModelListSearch $innerExp');
        }

      }
      videoModelListSearchNormal.forEach((element) {
        //print(element.toJson());
        //log(element.toJson().toString());
      });
      videoModelListSearch = Future.delayed(Duration.zero,()=>videoModelListSearchNormal);
      notifyListeners();
      //return featuredVideoModelList;
    }catch(exp){
      print('VideoProvider->requestVideoModelListSearch exp');
      print(exp);
      //return Future.delayed(Duration.zero,()=>null);
    }
  }

  // ဒါကတော့ ပုံမှန် select all လုပ်တာပါပဲ
  Future<void> requestVideoModelListLatestUpdate()async{
    try{
      var body = {
        'last_id':'0',
        'limit':'100'
      };
      var response =  await http.post(apiEndpointLatest,body:body);

      print("VideoProvider->requestVideoModelListLatestUpdate response");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map<String, dynamic> dataResponse = jsonDecode(response.body);
      List<dynamic> dataList =  dataResponse['data'];  // list of wp-content
      //wpContentList = [];

      videoModelListLatestUpdateNormal = [];
      for(int i=0; i<dataList.length; i++){
        if(videoModelListLatestUpdateNormal == null){
        }
        try{
          videoModelListLatestUpdateNormal.add(VideoModel.fromJson(dataList[i]));
        }
        catch(exp){
          print("VideoProvider->inner exp");
          print(exp);
        }
      }
      videoModelListLatestUpdateNormal.forEach((element) {
        //print(element.toJson());
        //log(element.toJson().toString());
      });
      videoModelListLatestUpdate =  Future.delayed(Duration.zero,()=>videoModelListLatestUpdateNormal);
      notifyListeners();
    }catch(exp){
      print('WpContentProvider->requestVideoModelListLatestUpdate exp');
      print(exp);
      //return Future.delayed(Duration.zero,()=>null);
    }
  }
  // type နဲ့ လုပ်မယ် ဆိုပါတော့  type 1 = movie
  Future<void> requestVideoModelListMovie()async{
    print("VideoProvider->requestVideoModelListMovie");
    try{
      var body = {
        'type':'1', // 1 mean movie
        'last_id':'0',
        'limit':'100'
      };
      print(body);
      print(apiEndpointType);
      var response =  await http.post(apiEndpointType,body:body);


      print("VideoProvider->requestVideoModelListMovie response");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map<String, dynamic> dataResponse = jsonDecode(response.body);
      List<dynamic> dataList =  dataResponse['data'];  // list of wp-content
      //wpContentList = [];
      for(int i=0; i<dataList.length; i++){
        if(videoModelListMovieNormal == null){
          videoModelListMovieNormal = [];
        }
        try{
          videoModelListMovieNormal.add(VideoModel.fromJson(dataList[i]));
        }
        catch(exp){
          print("VideoProvider->requestVideoModelListMovie inner exp");
          print(exp);
        }
      }
      videoModelListMovieNormal.forEach((element) {
        //print(element.toJson());
        //log(element.toJson().toString());
      });
      videoModelListMovie =  Future.delayed(Duration.zero,()=>videoModelListMovieNormal);
      notifyListeners();
    }catch(exp){
      print('WpContentProvider->requestVideoModelListMovie exp');
      print(exp);
      //return Future.delayed(Duration.zero,()=>null);
    }
  }
  // type နဲ့ လုပ်မယ် type 2 = series
  Future<void> requestVideoModelListSeries()async{
    try{
      var body = {
        'type':'2', // 2 means series
        'last_id':'0',
        'limit':'100'
      };
      var response =  await http.post(apiEndpointType,body:body);

      print("VideoProvider->requestVideoModelListSeries response");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map<String, dynamic> dataResponse = jsonDecode(response.body);
      List<dynamic> dataList =  dataResponse['data'];  // list of wp-content
      //wpContentList = [];
      for(int i=0; i<dataList.length; i++){
        if(videoModelListSeriesNormal == null){
          videoModelListSeriesNormal = [];
        }
        videoModelListSeriesNormal.add(VideoModel.fromJson(dataList[i]));
      }
      videoModelListSeriesNormal.forEach((element) {
        //print(element.toJson());
        //log(element.toJson().toString());
      });
      videoModelListSeries =  Future.delayed(Duration.zero,()=>videoModelListSeriesNormal);
      notifyListeners();
    }catch(exp){
      print('WpContentProvider->requestVideoModelListSeries exp');
      print(exp);
      //return Future.delayed(Duration.zero,()=>null);
    }
  }


  // category စာရင်းတောင်းတာ
  Future<void> requestCategoryModelList()async{
    try{
      var body = {
        'last_id':'0',
        'limit':'100'
      };
      var response =  await http.post(apiEndpointCategorySelect,body:body);

      print("VideoProvider->requestCategoryModelListFeatured response");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map<String, dynamic> dataResponse = jsonDecode(response.body);
      List<dynamic> dataList =  dataResponse['data'];  // list of wp-content
      //wpContentList = [];
      categoryModelListNormal = [];
      for(int i=0; i<dataList.length; i++){
        if(categoryModelListNormal == null){
          categoryModelListNormal = [];
        }
        categoryModelListNormal.add(CategoryModel.fromJson(dataList[i]));
      }
      categoryModelListNormal.forEach((element) {
        //print(element.toJson());
        //log(element.toJson().toString());
      });
      categoryModelList = Future.delayed(Duration.zero,()=>categoryModelListNormal);
      notifyListeners();
      //return featuredVideoModelList;
    }catch(exp){
      print('VideoProvider->requestCategoryModelListFeatured exp');
      print(exp);
      //return Future.delayed(Duration.zero,()=>null);
    }
  }

  // ဖိုင်ကို ဘာသာပြ်န်ဖို့ တောင်းဆိုတာ download link ပေးပါပေါ့
  Future<String> requestFileDownloadUrl(FileModel fileModel)async{
    try{
      var body = {
        'filename':fileModel.name,
      };
      var response =  await http.post(apiEndpointFileModelSelect,body:body);

      print("VideoProvider->requestFileDownloadUrl response");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map<String, dynamic> dataResponse = jsonDecode(response.body);
      String file_download_url =  dataResponse['data'];  // list of wp-content
      print('file_download_url is');
      print(file_download_url);
      return Future.delayed(Duration.zero,()=>file_download_url);

    }catch(exp){
      print('VideoProvider->requestFileDownloadUrl exp');
      print(exp);
      return Future.delayed(Duration.zero,()=>null);
    }
  }

  void setVideoDetail(VideoModel videoModel){
    print("setVideoDetail");
    print(videoModel.name);
    detailVideoModel = videoModel;
  }

  void setFileModelDetail(FileModel fileModel){
    detailFileModel = fileModel;
    // request file url
  }

  void setCategoryDetail(CategoryModel categoryModel){
    detailCategoryModel = categoryModel;
    // and request too
    videoModelListCategoryNormal = []; // clean old data
    videoModelListCategory = Future.delayed(Duration.zero,()=>videoModelListCategoryNormal);
    requestVideoModelListCategory(categoryModel.id);
  }
  void setCategoryNameDetail(CategoryModel categoryModel) {
    detailCategoryModel = categoryModel;
  }
  void getMovieList(){
    print('getMovieOrSeriesList');
    videoModelListCategoryNormal = []; // clean old data
    videoModelListCategory = Future.delayed(Duration.zero,()=>videoModelListCategoryNormal);
    videoModelListCategory = Future.delayed(Duration.zero,()=>videoModelListMovieNormal);
    notifyListeners();
  }

  void getSeriesList(){
    print('getSeriesList');
    videoModelListCategoryNormal = []; // clean old data
    videoModelListCategory = Future.delayed(Duration.zero,()=>videoModelListCategoryNormal);
    //videoModelListCategory = Future.delayed(Duration.zero,()=>videoModelListSeriesNormal);
    notifyListeners();
  }
  void setYearDetail(int year){
    detailYear = year;
    // and request too
    videoModelListYearNormal = [];
    videoModelListYear = Future.delayed(Duration.zero,()=>videoModelListYearNormal);
    requestVideoModelListYear(year);
  }



}