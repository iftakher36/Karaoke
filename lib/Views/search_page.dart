import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:karaoke/Model/Api/api_response.dart';
import 'package:provider/provider.dart';

import '../Utils/app_theme.dart';
import '../Utils/constants.dart';
import '../ViewModel/favourite_viewmodel.dart';
import '../ViewModel/search_viewmodel.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingControllerSearch = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<SearchViewModel>(context, listen: false).resetData();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppTheme.darkPrimaryColorLight,
        body: SafeArea(
          child: Consumer<FavouriteViewModel>(builder: (context, data, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
                  child: TextField(
                    onChanged: (txt) {
                      Provider.of<SearchViewModel>(context, listen: false)
                          .getSearchVideos(
                              context, textEditingControllerSearch.text);
                    },
                    controller: textEditingControllerSearch,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, top: 15),
                      hintText: "Search here",
                      focusColor: Colors.white,
                      labelStyle: TextStyle(
                        color: Color(0xC3EFEFF3),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      suffixIcon: Icon(
                        Icons.slow_motion_video_outlined,
                        color: Color(0xC3EFEFF3),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Expanded(
                  child: Consumer<SearchViewModel>(
                      builder: (context, data, child) {
                    return data.apiResponseSearch?.status!=Status.LOADING
                        ? data.search.isEmpty
                            ? const Center(child: Text("Search result empty"))
                            : ListView.builder(
                                controller: scrollController,
                                itemCount: data.search.length,
                                itemBuilder: (ctx, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Stack(
                                            children: [
                                              Hero(
                                                transitionOnUserGestures: true,
                                                tag: Constant.imgThumb +
                                                    data.search[index].thumb +
                                                    index.toString(),
                                                child: CachedNetworkImage(
                                                  height: 200,
                                                  width: 140,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                          downloadProgress) {
                                                    return Center(
                                                      child: CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                    );
                                                  },
                                                  fit: BoxFit.fill,
                                                  imageUrl: Constant.imgThumb +
                                                      data.search[index].thumb,
                                                ),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  splashColor: AppTheme
                                                      .darkSecondaryColor,
                                                  onTap: () {
                                                    Navigator.pushNamed(context,
                                                        Constant.details,
                                                        arguments: {
                                                          "img": Constant
                                                                  .imgThumb +
                                                              data.search[index]
                                                                  .thumb,
                                                          "index": index,
                                                          "title": data
                                                              .search[index]
                                                              .title,
                                                          "id": data
                                                              .search[index].id,
                                                          "video": Constant
                                                                  .videoThumb +
                                                              data.search[index]
                                                                  .video
                                                        });
                                                  },
                                                  child: const SizedBox(
                                                    height: 200,
                                                    width: 140,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  data.search[index].title,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${data.search != null ? data.search[index].relaseYear : "----"} | ${data.getReadyTag(index)} |",
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width <
                                                                400
                                                            ? 10
                                                            : 12),
                                                  ),
                                                  Text(
                                                    "⭐ ${data.search != null ? data.search[index].rating : ""}",
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width <
                                                                400
                                                            ? 7
                                                            : 10),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width <
                                                                  400
                                                              ? 100
                                                              : 200,
                                                      height: 120,
                                                      child: Html(
                                                        data:
                                                            "${data.search != null ? data.search[index].description : ""}",
                                                      ),
                                                    ),
                                                    ClipRRect(
                                                      child: BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                                sigmaY: 3,
                                                                sigmaX: 3),
                                                        child: SizedBox(
                                                          height: 5,
                                                          child: Container(
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                  }),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        if (scrollController.hasClients &&
            scrollController.offset ==
                scrollController.position.maxScrollExtent) {
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerSearch.dispose();
    super.dispose();
  }
}
