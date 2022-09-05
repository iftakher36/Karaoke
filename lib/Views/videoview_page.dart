import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karaoke/Utils/app_theme.dart';
import 'package:karaoke/ViewModel/video_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';
import '../ViewModel/details_viewmodel.dart';

class VideoViewPage extends StatefulWidget {
  const VideoViewPage({Key? key}) : super(key: key);

  @override
  State<VideoViewPage> createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<DetailsViewModel>(context, listen: false)
          .chewieController
          ?.play();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Provider.of<DetailsViewModel>(context, listen: false).pausePlayer();
          return true;
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppTheme.darkPrimaryColorLight,
            body: Chewie(
              controller:
                  Provider.of<DetailsViewModel>(context).chewieController!,
            ),
          ),
        ));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        Provider.of<DetailsViewModel>(context, listen: false).pausePlayer();
        break;
      case AppLifecycleState.resumed:
        Provider.of<DetailsViewModel>(context, listen: false).startPlayer();
        break;
      case AppLifecycleState.inactive:
        Provider.of<DetailsViewModel>(context, listen: false).pausePlayer();
        break;
      case AppLifecycleState.paused:
        Provider.of<DetailsViewModel>(context, listen: false).pausePlayer();
        break;
    }
  }
}
