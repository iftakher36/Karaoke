import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:karaoke/Utils/app_theme.dart';
import 'package:karaoke/ViewModel/user_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../Model/Api/api_response.dart';
import '../Model/Api/app_exception.dart';
import '../Model/DataModel/details_model.dart';
import '../Model/repository/user_repo.dart';

class DetailsViewModel with ChangeNotifier {
  ApiResponse? apiResponse;
  DetailsModel? detailsModel;
  final double _defaultHeight = 400;
  final double _transStart = 300;
  final ScrollController _scrollController = ScrollController();
  Map? data;
  String? img, tag, title, video;
  String videoTags = "";
  int? id;
  double _top = 500, _scale = 1, offset = 0.0;
  bool exceededHeight = false,
      _isInFav = false,
      _isExpanded = false,
      _isPlayable = false;

  //for next page
  ChewieController? chewieController;
  late VideoPlayerController videoPlayerController;

  init(String video) async {
    videoPlayerController = VideoPlayerController.network(video);

    await videoPlayerController.initialize().then((valu) {
      _isPlayable = true;
      notifyListeners();
    });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      zoomAndPan: true,
      allowedScreenSleep: false, 
      hideControlsTimer: const Duration(seconds: 4),
    );
    notifyListeners();
  }

  addListeners() {
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        double top = 500;
        offset = _scrollController.offset;
        top -= offset;
        _top = top;

        if (offset < _defaultHeight - transStart) {
          _scale = 1.00;
        } else if (offset < defaultHeight - transEnd) {
          _scale = (defaultHeight - transEnd - offset) / transEnd;
        } else {
          _scale = 0.0;
        }
        if (offset + kToolbarHeight > 500) {
          exceededHeight = true;
          notifyListeners();
        } else {
          exceededHeight = false;
          notifyListeners();
        }
        notifyListeners();
      }
    });
  }

  changeFavourite(BuildContext context) async {
    if (detailsModel != null && detailsModel!.data.isFavorite) {
      //remove
      try {
        detailsModel?.data.setFav = true;
        notifyListeners();
        dynamic res = await UserRepo().deleteWithAuth(
            "api/videos/fovorites/$id",
            Provider.of<UserViewModel>(context, listen: false)
                .userInfo!
                .accessToken);
        if (res.statusCode == 200) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(res.data['message'])));
        } else if (res.statusCode == 401) {}
      } on Exception catch (e) {
        if (e is FetchDataException) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      }
    } else {
      //add
      try {
        detailsModel?.data.setFav = true;
        _isInFav = !isInFav;
        notifyListeners();
        dynamic res = await UserRepo().postWithAuth(
            "api/videos/fovorites?",
            {'video_id': id},
            Provider.of<UserViewModel>(context, listen: false)
                .userInfo!
                .accessToken);
        if (res.statusCode == 200) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(res.data['message'])));
        } else if (res.statusCode == 401) {}
      } on Exception catch (e) {
        if (e is FetchDataException) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      }
    }

    notifyListeners();
  }

  expandCollapse() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  getRouteData(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map;
    img = data!["img"];
    tag = (img! + data!["index"].toString());
    title = data!["title"];
    id = data!["id"];
    video = data!["video"];
    init(video!);
/*    notifyListeners();*/
  }

  resetData(BuildContext context) {
    Navigator.pop(context);
    _top = 500;
    _scale = 1;
    offset = 0.0;
    exceededHeight = false;
    _isInFav = false;
    _isExpanded = false;
    _isPlayable = false;
    video = null;
    title = null;
    videoTags = "";
    detailsModel = null;
    chewieController?.dispose();
    videoPlayerController.dispose();
    chewieController=null;
    notifyListeners();
  }

  get isPlayable => _isPlayable;

  get isExpanded => _isExpanded;

  get isInFav => _isInFav;

  double get top => _top;

  double get defaultHeight => _defaultHeight;

  double get transStart => _transStart;

  double get transEnd => _transStart / 2;

  get scale => _scale;

  ScrollController get scrollController => _scrollController;

  pausePlayer() {
    if (chewieController != null && chewieController!.isPlaying) {
      chewieController!.pause();
      notifyListeners();
    }
  }

  startPlayer() {
    if (chewieController != null && !chewieController!.isPlaying) {
      chewieController!.play();
      notifyListeners();
    }
  }

  getDetailsData(BuildContext context) async {
    try {
      apiResponse = ApiResponse.loading("loading");
      notifyListeners();
      dynamic res = await UserRepo().getWithAuth(
          "api/videos/$id",
          Provider.of<UserViewModel>(context, listen: false)
              .userInfo!
              .accessToken);
      if (res.statusCode == 200) {
        apiResponse = ApiResponse.completed(res.data);
        detailsModel = DetailsModel.fromJson(apiResponse?.data);
        getReadyTag();
        notifyListeners();
      } else if (res.statusCode == 401) {
        print(res.data);
      }
    } on Exception catch (e) {
      if (e is FetchDataException) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  getReadyTag() {
    if (detailsModel != null && detailsModel!.data.category.name.isNotEmpty) {
      videoTags += detailsModel!.data.category.name;
    }
    if (detailsModel != null && detailsModel!.data.tags.isNotEmpty) {
      for (int i = 0; i < detailsModel!.data.tags.length; i++) {
        videoTags += "," + detailsModel!.data.tags[i].name;
      }
    }
  }
}
