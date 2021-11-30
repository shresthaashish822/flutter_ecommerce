import 'package:ecommerce/constant/color_properties.dart';
import 'package:ecommerce/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<Widget> pages;

  CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.pages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SizeConfig.widthMultiplier * 10.0),
            topRight: Radius.circular(SizeConfig.widthMultiplier * 10.0),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: primaryColor,
            elevation: 1.0,
            iconSize: SizeConfig.widthMultiplier * 5.0,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(
                  CupertinoIcons.house,
                ),
                label: 'HOME',
                activeIcon: CircleAvatar(
                  child: const Icon(
                    CupertinoIcons.house_fill,
                    color: secondaryColor,
                  ),
                  backgroundColor: colorWhite,
                  minRadius: SizeConfig.widthMultiplier * 5.0,
                ),
              ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.heart),
                label: 'FAV',
                activeIcon: CircleAvatar(
                  child: const Icon(
                    CupertinoIcons.heart_fill,
                    color: secondaryColor,
                  ),
                  backgroundColor: colorWhite,
                  minRadius: SizeConfig.widthMultiplier * 5.0,
                ),
              ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.person_alt_circle),
                label: 'PROFILE',
                activeIcon: CircleAvatar(
                  child: const Icon(
                    CupertinoIcons.person_alt_circle_fill,
                    color: secondaryColor,
                  ),
                  backgroundColor: colorWhite,
                  minRadius: SizeConfig.widthMultiplier * 5.0,
                ),
              ),
            ],
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}

class BottomNavBar {
  String? title;
  Icon? icon;
  BottomNavBar({this.title, this.icon});
}
