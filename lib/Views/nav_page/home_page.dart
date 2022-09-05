import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karaoke/Utils/app_theme.dart';
import 'package:karaoke/Utils/constants.dart';
import 'package:karaoke/ViewModel/details_viewmodel.dart';
import 'package:karaoke/ViewModel/home_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../Model/Api/api_response.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppTheme.darkPrimaryColorLight,
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Choose Genre",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          color: AppTheme.iconColorDark,
                          onPressed: () {
                            Navigator.of(context).pushNamed(Constant.search);
                          },
                          icon: const Icon(Icons.search_rounded),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SingleChildScrollView(
                      child: Provider.of<HomeViewModel>(context, listen: false)
                                  .apiResponseCat
                                  ?.status ==
                              Status.LOADING
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Provider.of<HomeViewModel>(context)
                                  .categories
                                  .isNotEmpty
                              ? Wrap(
                                  children: List.generate(
                                      Provider.of<HomeViewModel>(context)
                                          .categories
                                          .length, (index) {
                                    return Consumer<HomeViewModel>(
                                        builder: (ctx, data, child) {
                                      return GestureDetector(
                                        onTap: () {
                                          Provider.of<HomeViewModel>(context,
                                                  listen: false)
                                              .pagePopular = 1;
                                          Provider.of<HomeViewModel>(context,
                                                  listen: false)
                                              .movie = [];
                                          data.updateIndex(index);
                                          data.getPopularVideos(context);
                                        },
                                        child: SizedBox(
                                          width: 90,
                                          height: 40,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            elevation: 5,
                                            color: data.categories[index]
                                                    .isSelected
                                                ? AppTheme.darkSecondaryColor
                                                : AppTheme
                                                    .darkPrimaryColorLight,
                                            child: Center(
                                              child: Text(
                                                data.categories[index].name,
                                                style: TextStyle(
                                                    color: data
                                                            .categories[index]
                                                            .isSelected
                                                        ? Colors.white
                                                        : Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  }),
                                )
                              : const Center(child: Text("No video available")),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 25, top: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Popular",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 280,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Consumer<HomeViewModel>(
                          builder: (context, data, child) {
                        return data.apiResponsePopular?.status ==
                                Status.LOADING
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : data.movie.isNotEmpty
                                ? ListView.builder(
                                    controller: data.scrollControllerPopular,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: data.movie.length + 1,
                                    itemBuilder: (ctx, index) {
                                      return data.movie.length == index &&
                                              data.videos?.nextPageUrl != null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: AppTheme
                                                    .darkSecondaryColor,
                                              )),
                                            )
                                          : index < data.movie.length
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: SizedBox(
                                                    child: Column(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25),
                                                          child: Stack(
                                                            children: [
                                                              Hero(
                                                                transitionOnUserGestures:
                                                                    true,
                                                                tag: Constant
                                                                        .imgThumb +
                                                                    data
                                                                        .movie[
                                                                            index]
                                                                        .thumb +
                                                                    index
                                                                        .toString(),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  height: 220,
                                                                  width: 140,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  progressIndicatorBuilder:
                                                                      (context,
                                                                          url,
                                                                          downloadProgress) {
                                                                    return Center(
                                                                      child: CircularProgressIndicator(
                                                                          value:
                                                                              downloadProgress.progress),
                                                                    );
                                                                  },
                                                                  imageUrl: Constant
                                                                          .imgThumb +
                                                                      data.movie[index]
                                                                          .thumb,
                                                                ),
                                                              ),
                                                              Material(
                                                                color: Colors
                                                                    .transparent,
                                                                child:
                                                                    InkWell(
                                                                  splashColor:
                                                                      AppTheme
                                                                          .darkSecondaryColor,
                                                                  onTap: () {
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        Constant
                                                                            .details,
                                                                        arguments: {
                                                                          "img":
                                                                              Constant.imgThumb + data.movie[index].thumb,
                                                                          "index":
                                                                              index,
                                                                          "title":
                                                                              data.movie[index].title,
                                                                          "id":
                                                                              data.movie[index].id,
                                                                          "video":
                                                                              Constant.videoThumb + data.movie[index].video
                                                                        });
                                                                  },
                                                                  child:
                                                                      const SizedBox(
                                                                    height:
                                                                        220,
                                                                    width:
                                                                        140,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                            data.movie[index]
                                                                .title,
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        Text(
                                                            data.movie[index]
                                                                    .relaseYear +
                                                                " - " +
                                                                data
                                                                    .movie[
                                                                        index]
                                                                    .artistName,
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            style: const TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white38)),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container();
                                    })
                                : const Center(
                                    child: Text("No video available"));
                      }),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 25, top: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "For you",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 280,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Consumer<HomeViewModel>(
                          builder: (context, data, child) {
                        return data.apiResponseForYou?.status ==
                                Status.LOADING
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : data.forYou.isNotEmpty
                                ? ListView.builder(
                                    controller: data.scrollControllerForYou,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: data.forYou.length,
                                    itemBuilder: (ctx, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: SizedBox(
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                child: Stack(
                                                  children: [
                                                    Hero(
                                                      transitionOnUserGestures:
                                                          true,
                                                      tag: Constant.imgThumb +
                                                          data.forYou[index]
                                                              .thumb +
                                                          index.toString(),
                                                      child:
                                                          CachedNetworkImage(
                                                        height: 220,
                                                        width: 140,
                                                        fit: BoxFit.fill,
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                downloadProgress) {
                                                          return Center(
                                                            child: CircularProgressIndicator(
                                                                value: downloadProgress
                                                                    .progress),
                                                          );
                                                        },
                                                        imageUrl: Constant
                                                                .imgThumb +
                                                            data.forYou[index]
                                                                .thumb,
                                                      ),
                                                    ),
                                                    Material(
                                                      color:
                                                          Colors.transparent,
                                                      child: InkWell(
                                                        splashColor: AppTheme
                                                            .darkSecondaryColor,
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              Constant
                                                                  .details,
                                                              arguments: {
                                                                "img": Constant
                                                                        .imgThumb +
                                                                    data
                                                                        .forYou[
                                                                            index]
                                                                        .thumb,
                                                                "index":
                                                                    index,
                                                                "title": data
                                                                    .forYou[
                                                                        index]
                                                                    .title,
                                                                "id": data
                                                                    .forYou[
                                                                        index]
                                                                    .id,
                                                                "video": Constant
                                                                        .videoThumb +
                                                                    data
                                                                        .forYou[
                                                                            index]
                                                                        .video
                                                              });
                                                        },
                                                        child: const SizedBox(
                                                          height: 220,
                                                          width: 140,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                  data.forYou[index]
                                                          .relaseYear +
                                                      " - " +
                                                      data.forYou[index]
                                                          .artistName,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white38)),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : const Center(
                                    child: Text("No video available"));
                      }),
                    ),
                  ),
                ]),
              )),
        ],
      ),
    ));
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeViewModel>(context, listen: false).getCategories(context);
      Provider.of<HomeViewModel>(context, listen: false).getPlaceHolderImage();
      Provider.of<HomeViewModel>(context, listen: false)
          .getPopularVideos(context);
      Provider.of<HomeViewModel>(context, listen: false).getForYou(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<HomeViewModel>(context, listen: false)
        .scrollControllerForYou
        .dispose();
    Provider.of<HomeViewModel>(context, listen: false)
        .scrollControllerPopular
        .dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
