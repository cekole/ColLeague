import 'package:col_league/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import "package:latlong2/latlong.dart";

class RecentPlaces extends StatelessWidget {
  const RecentPlaces({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Places You Worked At',
          style: TextStyle(
            fontSize: 16,
            color: kprimaryColor,
          ),
        ),
        SizedBox(
          height: 8,
        ),
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
                          borderRadius: BorderRadius.circular(8.0),
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
    );
  }
}
