import 'package:flutter/material.dart';
import 'package:karaoke/Utils/app_theme.dart';
import 'package:karaoke/ViewModel/details_viewmodel.dart';
import 'package:karaoke/ViewModel/favourite_viewmodel.dart';
import 'package:karaoke/ViewModel/home_viewmodel.dart';
import 'package:karaoke/ViewModel/host_viewmodel.dart';
import 'package:karaoke/ViewModel/search_viewmodel.dart';
import 'package:karaoke/ViewModel/signup_viewmodel.dart';
import 'package:karaoke/ViewModel/user_viewmodel.dart';
import 'package:karaoke/ViewModel/video_viewmodel.dart';
import 'package:karaoke/Views/details_page.dart';
import 'package:karaoke/Views/host_page.dart';
import 'package:karaoke/Views/login_page.dart';
import 'package:karaoke/Views/nav_page/favourite_page.dart';
import 'package:karaoke/Views/nav_page/home_page.dart';
import 'package:karaoke/Views/search_page.dart';
import 'package:karaoke/Views/sign_up.dart';
import 'package:karaoke/Views/videoview_page.dart';
import 'package:provider/provider.dart';

import 'Utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => HostViewModel()),
        ChangeNotifierProvider(create: (ctx) => FavouriteViewModel()),
        ChangeNotifierProvider(create: (ctx) => HomeViewModel()),
        ChangeNotifierProvider(create: (ctx) => DetailsViewModel()),
        ChangeNotifierProvider(create: (ctx) => VideoViewModel()),
        ChangeNotifierProvider(create: (ctx) => UserViewModel()),
        ChangeNotifierProvider(create: (ctx) => SignUpViewModel()),
        ChangeNotifierProvider(create: (ctx) => SearchViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routes: {
          Constant.login: (ctx) => const LoginPage(),
          Constant.host: (ctx) => const HostPage(),
          Constant.details: (ctx) => const DetailsPage(),
          Constant.videos: (ctx) => const VideoViewPage(),
          Constant.signup: (ctx) => const SignUp(),
          Constant.search: (ctx) => const SearchPage(),

        },
      ),
    );
  }
}
