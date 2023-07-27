import 'package:col_league/constants/colors.dart';
import 'package:col_league/widgets/NavigationBar/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(
              color: kprimaryColor,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: kprimaryColor,
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(),
      ),
    );
  }
}
