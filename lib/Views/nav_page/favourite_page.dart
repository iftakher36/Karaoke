import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:karaoke/ViewModel/favourite_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../Utils/app_theme.dart';
import '../../Utils/constants.dart';
import '../../ViewModel/details_viewmodel.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FavouriteViewModel>(context, listen: false)
          .getFavouriteData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<FavouriteViewModel>(context, listen: false).resetData();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppTheme.darkPrimaryColorLight,
        body: Consumer<FavouriteViewModel>(builder: (context, data, child) {
          return data.favModel != null
              ? data.favModel!.data.length == 0
                  ? Center(child: const Text("No favourite added yet"))
                  : ListView.builder(
                      itemCount: data.favModel!.data.length,
                      itemBuilder: (ctx, index) {
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, top: 8, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      children: [
                                        Hero(
                                          transitionOnUserGestures: true,
                                          tag: Constant.imgThumb +
                                              data.favModel!.data[index].thumb +
                                              index.toString(),
                                          child: CachedNetworkImage(
                                            height: 200,
                                            width: 140,
                                            progressIndicatorBuilder: (context,
                                                url, downloadProgress) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress),
                                              );
                                            },
                                            fit: BoxFit.fill,
                                            imageUrl: Constant.imgThumb +
                                                data.favModel!.data[index]
                                                    .thumb,
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            splashColor:
                                                AppTheme.darkSecondaryColor,
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, Constant.details,
                                                  arguments: {
                                                    "img": Constant.imgThumb +
                                                        data.favModel!
                                                            .data[index].thumb,
                                                    "index": index,
                                                    "title": data.favModel!
                                                        .data[index].title,
                                                    "id": data.favModel!
                                                        .data[index].id,
                                                    "video":
                                                        Constant.videoThumb +
                                                            data
                                                                .favModel!
                                                                .data[index]
                                                                .video
                                                  }).then((value) {
                                                data.getFavouriteData(context);
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
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            data.favModel!.data[index].title,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${data.favModel != null ? data.favModel?.data[index].relaseYear : "----"} | ${data.getReadyTag(index)} |",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                                  .size
                                                                  .width <
                                                              400
                                                          ? 10
                                                          : 12),
                                            ),
                                            Text(
                                              "⭐ ${data.favModel != null ? data.favModel!.data[index].rating : ""}",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                                  .size
                                                                  .width <
                                                              400
                                                          ? 7
                                                          : 10),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width <
                                                    400
                                                ? 100
                                                : 200,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 120,
                                                  child: Html(
                                                    data:
                                                        "${data.favModel != null ? data.favModel!.data[index].description : ""}",
                                                  ),
                                                ),
                                                ClipRRect(
                                                  child: BackdropFilter(
                                                    filter:
                                                    ImageFilter.blur(sigmaY: 3, sigmaX: 3),
                                                    child: SizedBox(
                                                      height: 5,
                                                      child: Container(
                                                        color: Colors.transparent,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                top: 10,
                                left: 112,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: CircleAvatar(
                                    backgroundColor:
                                        AppTheme.darkPrimaryColorLight,
                                    child: IconButton(
                                      onPressed: () {
                                        data.removeFromfav(
                                            data.favModel!.data[index].id,
                                            index,
                                            context);
                                      },
                                      icon: Icon(Icons.favorite,
                                          color: AppTheme.darkOnPrimaryColor),
                                    ),
                                  ),
                                ))
                          ],
                        );
                      })
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
        }),
      ),
    );
  }
}
