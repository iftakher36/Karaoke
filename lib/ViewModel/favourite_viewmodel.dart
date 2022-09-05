import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karaoke/ViewModel/user_viewmodel.dart';
import 'package:provider/provider.dart';

import '../Model/Api/api_response.dart';
import '../Model/Api/app_exception.dart';
import '../Model/DataModel/favourite_model.dart';
import '../Model/DataModel/movie.dart';
import '../Model/repository/user_repo.dart';

class FavouriteViewModel with ChangeNotifier {
  ApiResponse? apiResponse;
  FavModel? favModel;

  getFavouriteData(BuildContext context) async {
    try {
      apiResponse = ApiResponse.loading("Loading");
      notifyListeners();
      dynamic res = await UserRepo().getWithAuth(
          "api/videos/fovorites?",
          Provider.of<UserViewModel>(context, listen: false)
              .userInfo!
              .accessToken);
      if (res.statusCode == 200) {
        apiResponse = ApiResponse.completed(res.data);

        favModel = FavModel.fromJson(apiResponse?.data);
        print(favModel?.data.length);
        notifyListeners();
      } else if (res.statusCode == 401) {}
    } on Exception catch (e) {
      if (e is FetchDataException) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  removeFromfav(int id, int index, BuildContext context) async {
    try {
      notifyListeners();
      dynamic res = await UserRepo().deleteWithAuth(
          "api/videos/fovorites/$id",
          Provider.of<UserViewModel>(context, listen: false)
              .userInfo!
              .accessToken);
      if (res.statusCode == 200) {
        favModel!.data.removeAt(index);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res.data['message'])));
      } else if (res.statusCode == 401) {}
    } on Exception catch (e) {
      if (e is FetchDataException) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
    notifyListeners();
  }

  resetData() {
    apiResponse = null;
    favModel = null;
    notifyListeners();
  }

  String getReadyTag(int index) {
    String videoTags = "";
    if (favModel != null && favModel!.data[index].category.name.isNotEmpty) {
      videoTags += favModel!.data[index].category.name;
    }
    if (favModel != null && favModel!.data[index].tags.isNotEmpty) {
      for (int i = 0; i < favModel!.data[index].tags.length; i++) {
        videoTags += "," + favModel!.data[index].tags[i].name;
      }
    }
    return videoTags;
  }
}
