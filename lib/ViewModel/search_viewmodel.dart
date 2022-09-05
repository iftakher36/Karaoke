import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karaoke/ViewModel/user_viewmodel.dart';
import 'package:provider/provider.dart';

import '../Model/Api/api_response.dart';
import '../Model/Api/app_exception.dart';
import '../Model/DataModel/videos_model.dart';
import '../Model/repository/user_repo.dart';

class SearchViewModel with ChangeNotifier {
  List<DatumVideo> search = [];
  ApiResponse? apiResponseSearch;
  bool isBusy = false;

  getSearchVideos(BuildContext context, String txt) async {
    if (!isBusy && txt.isNotEmpty) {
      try {
        isBusy = true;
        search.clear();
        apiResponseSearch = ApiResponse.loading("loading");
        notifyListeners();
        dynamic res = await UserRepo().getWithAuth(
            "api/videos?search=${txt}",
            Provider.of<UserViewModel>(context, listen: false)
                .userInfo!
                .accessToken);
        if (res.statusCode == 200) {
          apiResponseSearch = ApiResponse.completed(res);
          Videos videos = Videos.fromJson(res.data);
          search = videos.data;
          isBusy = false;
          notifyListeners();
        } else if (res.statusCode == 400) {
          apiResponseSearch = ApiResponse.completed(res);
          isBusy = false;
        }
      } on Exception catch (e) {
        isBusy = false;
        if (e is FetchDataException) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
       }
    }
  }

  void resetData() {
    apiResponseSearch = null;
    search = [];
    isBusy=false;
  }

  String getReadyTag(int index) {
    String videoTags = "";
    if (search != null && search[index].category.name.isNotEmpty) {
      videoTags += search[index].category.name;
    }
    if (search != null && search[index].tags.isNotEmpty) {
      for (int i = 0; i < search[index].tags.length; i++) {
        videoTags += "," + search[index].tags[i].name;
      }
    }
    return videoTags;
  }
}
