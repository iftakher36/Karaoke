import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:karaoke/Utils/app_theme.dart';
import 'package:karaoke/Utils/constants.dart';
import 'package:provider/provider.dart';
import '../ViewModel/details_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<DetailsViewModel>(context, listen: false).addListeners();
      Provider.of<DetailsViewModel>(context, listen: false)
          .getRouteData(context);
      Provider.of<DetailsViewModel>(context, listen: false)
          .getDetailsData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailsViewModel>(builder: (context, data, child) {
      return WillPopScope(
        onWillPop: () async {
          data.resetData(context);
          return true;
        },
        child: Scaffold(
            backgroundColor: AppTheme.darkPrimaryColorLight,
            body: Stack(
              children: [
                CustomScrollView(
                  controller: data.scrollController,
                  slivers: [
                    SliverAppBar(
                      toolbarHeight: kToolbarHeight,
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: IconButton(
                              onPressed: () {
                                data.resetData(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                          ),
                        ),
                      ),
                      title: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: data.exceededHeight ? 1 : 0,
                          child: Text(
                            data.title != null ? data.title! : "",
                          )),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            clipBehavior: Clip.hardEdge,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                              child: IconButton(
                                onPressed: () {
                                  Provider.of<DetailsViewModel>(context,
                                          listen: false)
                                      .changeFavourite(context);
                                },
                                icon: data.detailsModel != null
                                    ? data.detailsModel!.data.isFavorite
                                        ? Icon(Icons.favorite,
                                            color: AppTheme.darkOnPrimaryColor)
                                        : Icon(Icons.favorite_border,
                                            color: AppTheme.darkOnPrimaryColor)
                                    : data.isInFav
                                        ? Icon(Icons.favorite,
                                            color: AppTheme.darkOnPrimaryColor)
                                        : Icon(Icons.favorite_border,
                                            color: AppTheme.darkOnPrimaryColor),
                              ),
                            ),
                          ),
                        )
                      ],
                      automaticallyImplyLeading: false,
                      pinned: true,
                      expandedHeight: 500,
                      backgroundColor: AppTheme.darkPrimaryColorLight,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Hero(
                          transitionOnUserGestures: true,
                          tag: data.tag != null ? data.tag! : "",
                          child: CachedNetworkImage(
                            imageUrl: data.img != null
                                ? data.img!
                                : "img/gallery.png",
                            fit: BoxFit.fill,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) {
                              return Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              );
                            },
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 800,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedOpacity(
                                opacity: data.exceededHeight == false ? 1 : 0,
                                duration: const Duration(milliseconds: 400),
                                child: data.exceededHeight == false
                                    ? Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          data.title != null ? data.title! : "",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                      )
                                    : Container(),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${data.detailsModel != null ? data.detailsModel?.data.relaseYear : "----"} | ${data.detailsModel != null ? data.videoTags : "----"} |",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height <
                                                    768
                                                ? 12
                                                : 15),
                                  ),
                                  Text(
                                    "⭐ ${data.detailsModel != null ? data.detailsModel?.data.rating : "----"}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  height: data.isExpanded ? null : 100,
                                  child: data.detailsModel != null
                                      ? Html(
                                          data:
                                              "${data.detailsModel?.data.description}",
                                        )
                                      : null,
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
                              data.detailsModel != null?Center(
                                child: IconButton(
                                    onPressed: () {
                                      Provider.of<DetailsViewModel>(context,
                                              listen: false)
                                          .expandCollapse();
                                    },
                                    icon: Icon(data.isExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down)),
                              ):Container()
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height > 1080
                      ? data.top + 10
                      : MediaQuery.of(context).size.height < 768
                          ? data.top - 20
                          : data.top - 10,
                  right: 20,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(data.scale),
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: FloatingActionButton(
                          tooltip: "Play",
                          elevation: 10,
                          child: Icon(
                            Icons.play_arrow_outlined,
                            color: data.isPlayable ? Colors.white : Colors.grey,
                            size: 45,
                          ),
                          onPressed: () {
                            if (data.isPlayable) {
                              Navigator.of(context).pushNamed(Constant.videos);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Preparing video for you...")));
                            }
                          }),
                    ),
                  ),
                )
              ],
            )),
      );
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    switch (state) {
      case AppLifecycleState.resumed:
        Provider.of<DetailsViewModel>(context, listen: false).pausePlayer();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        Provider.of<DetailsViewModel>(context, listen: false)
            .scrollController
            .dispose();
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
