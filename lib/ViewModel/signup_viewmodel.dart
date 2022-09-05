import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:karaoke/Model/Api/api_response.dart';
import 'package:karaoke/Model/Api/app_exception.dart';
import 'package:karaoke/Model/DataModel/error_model.dart';
import 'package:karaoke/Model/Services/user_service.dart';
import 'package:karaoke/Model/repository/user_repo.dart';
import 'package:karaoke/Utils/constants.dart';

class SignUpViewModel with ChangeNotifier {
  ApiResponse? apiResponse;
  bool _securesPass = true, _secureCpass = true;

  bool get securesPass => _securesPass;

  set securesPass(bool value) {
    _securesPass = value;
    notifyListeners();
  }

  signUp(BuildContext context, String name, String email, String pass,
      String cpass, String num) async {
    if (name.isEmpty ||
        email.isEmpty ||
        pass.isEmpty ||
        cpass.isEmpty ||
        num.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Fill out the field correctly")));
    } else {
      try {
        apiResponse = ApiResponse.loading("loading");
        loadingDialogue(context);
        notifyListeners();
        dynamic res = await UserRepo().post(
            "api/registation?email=$email&password=$pass&confirmed_password=$cpass&name=$name&mobile=$num}");

        if (res.statusCode == 200) {
          apiResponse = ApiResponse.completed(res);
          Map map = Map.from(apiResponse?.data.data);
          if (map['message'].toLowerCase().toString() == "user created") {
            Navigator.popUntil(context, ModalRoute.withName(Constant.login));
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Registered successfully.. please login!")));
          }
        } else if (res.statusCode == 400) {
          apiResponse = ApiResponse.completed(res);
          //ErrorModel errorModel = ErrorModel.fromJson(apiResponse?.data);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Couldn't create user... try again")));
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

  get secureCpass => _secureCpass;

  set secureCpass(value) {
    _secureCpass = value;
    notifyListeners();
  }

  resetData() {
    securesPass = true;
    secureCpass = true;
    apiResponse=null;
  }
}
