import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karaoke/Model/Api/api_response.dart';
import 'package:karaoke/Model/DataModel/videos_model.dart';
import 'package:karaoke/ViewModel/user_viewmodel.dart';
import 'package:provider/provider.dart';
import '../Model/Api/app_exception.dart';
import '../Model/DataModel/category.dart';
import '../Model/DataModel/movie.dart';
import '../Model/repository/user_repo.dart';

class HomeViewModel with ChangeNotifier {
  ApiResponse? apiResponseForYou, apiResponsePopular, apiResponseCat;
  Uint8List? list;
  final ScrollController _scrollControllerPopular = ScrollController();
  final ScrollController _scrollControllerForYou = ScrollController();
  List<Datums> categories = [];
  List<DatumVideo> movie = [];
  List<DatumVideo> forYou = [];
  int pagePopular = 1, pageForYou = 1;
  bool isBusy = false;
  Videos? videos;

  getCategories(BuildContext context) async {
    try {
      apiResponseCat = ApiResponse.loading("loading");
      notifyListeners();
      dynamic res = await UserRepo().getWithAuth(
          "api/categories?",
          Provider.of<UserViewModel>(context, listen: false)
              .userInfo!
              .accessToken);

      if (res.statusCode == 200) {
        Catagories resData = Catagories.fromJson(res.data);
        categories = resData.data;
        notifyListeners();
      } else {
        print("category not found");
      }
      if (res.statusCode == 200) {
        apiResponseCat = ApiResponse.completed(res);
      } else if (res.statusCode == 400) {
        apiResponseCat = ApiResponse.completed(res);
      }
    } on Exception catch (e) {
      if (e is FetchDataException) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  getPopularVideos(BuildContext context) async {
    String catIds = "";
    for (int i = 0; i < categories.length; i++) {
      if (categories[i].isSelected) {
        catIds += "," + categories[i].id.toString();
      }
    }
    try {
      apiResponsePopular = ApiResponse.loading("loading");
      notifyListeners();
      dynamic res = await UserRepo().getWithAuth(
          catIds.isNotEmpty
              ? "api/videos?page=$pagePopular&categories=$catIds"
              : "api/videos?page=$pagePopular",
          Provider.of<UserViewModel>(context, listen: false)
              .userInfo!
              .accessToken);

      if (res.statusCode == 200) {
        videos = Videos.fromJson(res.data);
        movie.addAll(videos!.data);
        if (videos!.nextPageUrl != null) {
          pagePopular++;
        }
        notifyListeners();
      } else {}
      if (res.statusCode == 200) {
        apiResponsePopular = ApiResponse.completed(res);
      } else if (res.statusCode == 400) {
        apiResponsePopular = ApiResponse.completed(res);
      }
    } on Exception catch (e) {
      if (e is FetchDataException) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  getForYou(BuildContext context) async {
    try {
      apiResponseForYou = ApiResponse.loading("loading");
      notifyListeners();
      dynamic res = await UserRepo().getWithAuth(
          "api/videos/fovorites/for-you",
          Provider.of<UserViewModel>(context, listen: false)
              .userInfo!
              .accessToken);

      if (res.statusCode == 200) {
        apiResponseForYou = ApiResponse.completed(res);
        Videos videos = Videos.fromJson(res.data);
        forYou = videos.data;
        print("here");
        notifyListeners();
      } else if (res.statusCode == 400) {
        apiResponseForYou = ApiResponse.completed(res);
      }
    } on Exception catch (e) {
      if (e is FetchDataException) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  getPlaceHolderImage() async {
    final ByteData bytes = await rootBundle.load('img/logok.png');
    list = bytes.buffer.asUint8List();
    return list;
  }

  updateIndex(int index) {
    categories[index].isSelected = !categories[index].isSelected;
    notifyListeners();
  }

  resetVideoData() {
    pagePopular = 1;
    pageForYou = 1;
    isBusy = false;
    videos = null;
  }

  ScrollController get scrollControllerForYou => _scrollControllerForYou;

  ScrollController get scrollControllerPopular => _scrollControllerPopular;
}
