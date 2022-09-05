import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karaoke/Model/DataModel/local/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:karaoke/Utils/constants.dart';

import '../Model/Api/app_exception.dart';
import '../Model/repository/user_repo.dart';

class UserViewModel with ChangeNotifier {
  late SharedPreferences prefs;
  UserInfo? userInfo;
  int? isFirst;
  bool _secures = true;

  bool get secures => _secures;

  set secures(bool value) {
    _secures = value;
    notifyListeners();
  }

  login(BuildContext context, String email, String pass) async {
    if (email.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Fill out the field correctly")));
    } else {
      try {
        loadingDialogue(context);
        notifyListeners();
        dynamic res =
            await UserRepo().post("api/login?email=$email&password=$pass");

        if (res.statusCode == 200) {
          setUserData(context, jsonEncode(res.data));
        } else if (res.statusCode == 401) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid Login details")));
        }
      } on Exception catch (e) {
        if (e is FetchDataException) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      }
    }
  }

  void loadingDialogue(BuildContext context) {
    AlertDialog alert = AlertDialog(
        content: SizedBox(
      height: 100,
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.all(5),
            child: const CircularProgressIndicator(
              strokeWidth: 5.0,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ],
      ),
    ));
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getSharedPreferences(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    //check if first time login or not
    isFirst = prefs.getInt(Constant.isFirstTime);
    userInfo =
        UserInfo.fromJson(jsonDecode(prefs.getString(Constant.userInfo)!));
    if (isFirst == 1) {
      //if not first time login then replace login page
      Navigator.pushReplacementNamed(context, Constant.host);
    }
  }

  setUserData(BuildContext context, String info) async {
    await prefs.setInt(Constant.isFirstTime, 1);
    await prefs.setString(Constant.userInfo, info);
    userInfo ??= UserInfo.fromJson(jsonDecode(info));

    ///when everything set then redirect to dashboard
    ///
    Navigator.of(context).pop();
    Navigator.of(context).popAndPushNamed(Constant.host);
  }
}
