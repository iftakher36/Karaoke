import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karaoke/Utils/app_theme.dart';
import 'package:karaoke/ViewModel/host_viewmodel.dart';
import 'package:provider/provider.dart';

class HostPage extends StatefulWidget {
  const HostPage({Key? key}) : super(key: key);

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<HostViewModel>(context).setContext(context);
    return WillPopScope(
      onWillPop: Provider.of<HostViewModel>(context).onWillPop,
      child: Scaffold(
        backgroundColor: AppTheme.darkPrimaryColorLight,
        body: PageView(
          controller: Provider.of<HostViewModel>(context).pageController,
          children: Provider.of<HostViewModel>(context).pages,
          onPageChanged: Provider.of<HostViewModel>(context).onPageChange,
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 20, right: 20),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: BottomNavigationBar(
                backgroundColor: AppTheme.darkSecondaryColor,
                type: BottomNavigationBarType.fixed,
                onTap: Provider.of<HostViewModel>(context).onTabTap,
                currentIndex: Provider.of<HostViewModel>(context).currentIndex,
                selectedItemColor: Colors.white,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                unselectedItemColor: Colors.black54.withOpacity(0.5),
                items: const [
                  BottomNavigationBarItem(
                      label: "Home", icon: Icon(Icons.home)),
                  BottomNavigationBarItem(
                      label: "Favourite", icon: Icon(Icons.favorite)),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "Settings")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
