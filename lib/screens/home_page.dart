import 'package:col_league/constants/colors.dart';
import 'package:col_league/screens/profile_page.dart';
import 'package:col_league/widgets/HomePage/people_working_near.dart';
import 'package:col_league/widgets/HomePage/recent_places.dart';
import 'package:col_league/widgets/NavigationBar/custom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/plugin_api.dart';
import "package:latlong2/latlong.dart";
import 'package:map_launcher/map_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool _isSearching = false;
  late AnimationController _animationController;
  late ColorTween _colorTween;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    _colorTween = ColorTween(begin: Colors.green, end: Colors.black);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      color: kprimaryColor,
                    ),
                  ),
                  title: const Text(
                    'ColLeague',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          //Navigate to profile page with Animation

                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 250),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      ProfilePage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: CircleAvatar(
                          foregroundImage: NetworkImage(
                              'https://avatars.githubusercontent.com/u/63546159?v=4'),
                        ),
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi there, \nCheck out people around you!',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: kprimaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        //Recent Places You Worked At
                        RecentPlaces(),
                        const SizedBox(
                          height: 16,
                        ),
                        //People Working Now Near You
                        PeopleWorkingNear(),

                        //Online Groups You Can Join
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Online Groups You Can Join',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kprimaryColor,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'See All',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: kprimaryColor.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                                height: 200,
                                child: //GridView of Groups
                                    GridView.builder(
                                        padding: const EdgeInsets.all(0),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                        ),
                                        itemCount: 6,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              //show bottom sheet with group details
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.6,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                16.0),
                                                        topRight:
                                                            Radius.circular(
                                                                16.0),
                                                      ),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          gradientColors[1],
                                                          gradientColors[0]
                                                              .withOpacity(0.5),
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                    ),
                                                    child: ListView(
                                                      children: [
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Group Name',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 21,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      kprimaryColor,
                                                                ),
                                                              ),
                                                              //join button
                                                              TextButton(
                                                                onPressed:
                                                                    () {},
                                                                child: Text(
                                                                  'Join',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: kprimaryColor
                                                                        .withOpacity(
                                                                            0.75),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        //GridView of Group Members
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.6,
                                                          child:
                                                              GridView.builder(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16),
                                                            gridDelegate:
                                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 3,
                                                              crossAxisSpacing:
                                                                  5,
                                                              mainAxisSpacing:
                                                                  5,
                                                            ),
                                                            itemCount: 6,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Column(
                                                                children: [
                                                                  Container(
                                                                    height: 80,
                                                                    width: 80,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      border: Border.all(
                                                                          color:
                                                                              kprimaryColor),
                                                                      image:
                                                                          DecorationImage(
                                                                        image: NetworkImage(
                                                                            'https://picsum.photos/200/300'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Name',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          kprimaryColor,
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https://picsum.photos/200/300'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          );
                                        })),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: CustomBottomNavBar(),
        ),
        Align(
          alignment: Alignment.bottomRight - Alignment(0.1, 0.3),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final color = _colorTween.evaluate(_animationController);
              return FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                  });
                  //TODO: add openToWork functionality
                },
                child: _isSearching
                    ? Icon(Icons.wifi_tethering_rounded, color: color)
                    : Icon(Icons.wifi_tethering_rounded),
                backgroundColor: gradientColors[0],
              );
            },
          ),
        ),
      ],
    );
  }
}
