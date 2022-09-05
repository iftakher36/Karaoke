import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karaoke/Utils/constants.dart';
import 'package:karaoke/ViewModel/signup_viewmodel.dart';
import 'package:provider/provider.dart';

import '../Utils/app_theme.dart';
import '../ViewModel/user_viewmodel.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController textEditingControllerName = TextEditingController(),
      textEditingControllerEmail = TextEditingController(),
      textEditingControllerPassword = TextEditingController(),
      textEditingControllerConfirmPass = TextEditingController(),
      textEditingControllerNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<SignUpViewModel>(context, listen: false).resetData();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppTheme.darkPrimaryColorLight,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Consumer<SignUpViewModel>(builder: (context, data, child) {
              return Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30, top: 5),
                        child: Container(
                          width: 110,
                          color: Colors.white,
                          height: 2,
                        ),
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 80, left: 30, right: 30),
                    child: TextField(
                      controller: textEditingControllerName,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        focusColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Color(0xC3EFEFF3),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        prefixIcon: Icon(
                          Icons.supervised_user_circle,
                          color: Color(0xC3EFEFF3),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
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
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xC3EFEFF3),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      controller: textEditingControllerNumber,
                      decoration: const InputDecoration(
                        labelText: "Mobile",
                        focusColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Color(0xC3EFEFF3),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        prefixIcon: Icon(Icons.phone, color: Color(0xC3EFEFF3)),
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Consumer<UserViewModel>(
                      builder: (ctx, userModel, child) {
                        return TextField(
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          controller: textEditingControllerPassword,
                          decoration: InputDecoration(
                              labelText: "Password",
                              focusColor: Colors.white,
                              labelStyle: const TextStyle(
                                color: Color(0xC3EFEFF3),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color(0xC3EFEFF3)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    data.securesPass == true
                                        ? Icons.remove_red_eye
                                        : Icons.security,
                                    color: const Color(0xC3EFEFF3)),
                                onPressed: () {
                                  data.securesPass = !data.securesPass;
                                },
                              )),
                          keyboardType: TextInputType.text,
                          obscureText: data.securesPass,
                          textInputAction: TextInputAction.next,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      controller: textEditingControllerConfirmPass,
                      decoration: InputDecoration(
                          labelText: "Confirm Password",
                          focusColor: Colors.white,
                          labelStyle: const TextStyle(
                            color: Color(0xC3EFEFF3),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          prefixIcon:
                              const Icon(Icons.lock, color: Color(0xC3EFEFF3)),
                          suffixIcon: IconButton(
                            icon: Icon(
                                data.secureCpass == true
                                    ? Icons.remove_red_eye
                                    : Icons.security,
                                color: const Color(0xC3EFEFF3)),
                            onPressed: () {
                              data.secureCpass = !data.secureCpass;
                            },
                          )),
                      keyboardType: TextInputType.text,
                      obscureText: data.securesPass,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 40, right: 30, bottom: 40),
                      child: SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              )),
                            ),
                            onPressed: () {
                              Provider.of<SignUpViewModel>(context,
                                      listen: false)
                                  .signUp(
                                      context,
                                      textEditingControllerName.text,
                                      textEditingControllerEmail.text,
                                      textEditingControllerPassword.text,
                                      textEditingControllerConfirmPass.text,
                                      textEditingControllerNumber.text);
                            },
                            child: const Text(
                              "Proceed",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingControllerNumber.dispose();
    textEditingControllerConfirmPass.dispose();
    textEditingControllerPassword.dispose();
    textEditingControllerEmail.dispose();
    textEditingControllerName.dispose();
    super.dispose();
  }
}
