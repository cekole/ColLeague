import 'package:col_league/constants/colors.dart';
import 'package:col_league/widgets/HomePage/recent_places.dart';
import 'package:col_league/widgets/NavigationBar/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/plugin_api.dart';
import "package:latlong2/latlong.dart";

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
                      child: CircleAvatar(
                        foregroundImage: NetworkImage(
                            'https://avatars.githubusercontent.com/u/63546159?v=4'),
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
                            color: gradientColors[1],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Popular Workspaces Near You',
                              style: TextStyle(
                                fontSize: 16,
                                color: gradientColors[1],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            //map of popular places
                            Container(
                              height: 140,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 8,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return IgnorePointer(
                                    child: SizedBox(
                                      width: 140,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: FlutterMap(
                                                options: MapOptions(
                                                  center: LatLng(51.5, -0.09),
                                                  zoom: 14,
                                                ),
                                                children: [
                                                  TileLayer(
                                                    urlTemplate:
                                                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                    subdomains: ['a', 'b', 'c'],

                                                    //for markers
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'London',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: gradientColors[1],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        //Recent Places You Worked At
                        RecentPlaces(),
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
        //FloatingActionButton in center b
        Align(
          alignment: Alignment.bottomCenter - Alignment(0, 0.3),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final color = _colorTween.evaluate(_animationController);
              return FloatingActionButton.small(
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                  });
                  //TODO: add openToWork functionality
                },
                child: _isSearching
                    ? Icon(Icons.wifi_tethering_rounded, color: color)
                    : Icon(Icons.wifi_tethering_rounded),
                backgroundColor: Colors.white,
              );
            },
          ),
        ),
      ],
    );
  }
}
