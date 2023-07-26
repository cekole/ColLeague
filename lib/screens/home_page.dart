import 'package:col_league/constants/colors.dart';
import 'package:col_league/widgets/Navigation%20Bar/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/plugin_api.dart';
import "package:latlong2/latlong.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Popular Places',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: gradientColors[1],
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    'See All',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: gradientColors[1],
                                    ),
                                  ),
                                ],
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
                                                      subdomains: [
                                                        'a',
                                                        'b',
                                                        'c'
                                                      ],

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
      ],
    );
  }
}
