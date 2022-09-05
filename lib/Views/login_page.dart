import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karaoke/Utils/app_theme.dart';
import 'package:provider/provider.dart';

import '../Utils/constants.dart';
import '../ViewModel/user_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController textEditingControllerEmail = TextEditingController(),
      textEditingControllerPss = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserViewModel>(context, listen: false)
          .getSharedPreferences(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Material(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(190)),
        color: AppTheme.darkPrimaryColorLight,
        child: Material(
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(220)),
          color: Colors.white,
          child: Material(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(250)),
            color: AppTheme.darkPrimaryColorLight,
            child: SafeArea(
              child: Column(
                children: [
                  Material(
                    elevation: 5,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: AppTheme.darkPrimaryColorLight,
                    child: SizedBox(
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Kara",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                          Text(
                            "oke",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 50, left: 30, right: 30),
                            child: TextField(
                              controller: textEditingControllerEmail,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: const InputDecoration(
                                labelText: "Email",
                                focusColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: Color(0xC3EFEFF3),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Color(0xC3EFEFF3),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 30, right: 30),
                            child: Consumer<UserViewModel>(
                              builder: (ctx, userModel, child) {
                                return TextField(
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: Colors.white,
                                  controller: textEditingControllerPss,
                                  decoration: InputDecoration(
                                      labelText: "Password",
                                      focusColor: Colors.white,
                                      labelStyle: const TextStyle(
                                        color: Color(0xC3EFEFF3),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      prefixIcon: const Icon(Icons.lock,
                                          color: Color(0xC3EFEFF3)),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            userModel.secures == true
                                                ? Icons.remove_red_eye
                                                : Icons.security,
                                            color: const Color(0xC3EFEFF3)),
                                        onPressed: () {
                                          Provider.of<UserViewModel>(ctx,
                                                  listen: false)
                                              .secures = !userModel.secures;
                                        },
                                      )),
                                  keyboardType: TextInputType.text,
                                  obscureText: userModel.secures,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: Text(
                                "Forgot Password?",
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 80, right: 30),
                              child: SizedBox(
                                height: 50,
                                width: 200,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        side: const BorderSide(
                                          color: Colors.white,
                                          width: 1.0,
                                        ),
                                      )),
                                    ),
                                    onPressed: () {
                                      Provider.of<UserViewModel>(context,
                                              listen: false)
                                          .login(
                                              context,
                                              textEditingControllerEmail.text,
                                              textEditingControllerPss.text);
                                    },
                                    child: const Text(
                                      "Log In",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text("Not registered yet?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto")),
                                const SizedBox(
                                  width: 5,
                                ),
                                Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        splashColor:
                                            AppTheme.darkSecondaryColor,
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Constant.signup);
                                        },
                                        child: Text(
                                          "SignUp",
                                          style: TextStyle(
                                              fontSize: 15,
                                              decoration:
                                                  TextDecoration.underline,
                                              color:
                                                  AppTheme.darkSecondaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Roboto"),
                                        ))),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingControllerEmail.dispose();
    textEditingControllerPss.dispose();
    super.dispose();
  }
}
