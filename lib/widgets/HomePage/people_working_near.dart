import 'package:col_league/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

class PeopleWorkingNear extends StatelessWidget {
  const PeopleWorkingNear({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'People Working Now Near You',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Container(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 8,
              );
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  //modal bottom sheet with user info and the place they are working at right now
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              gradientColors[1],
                              gradientColors[0].withOpacity(0.5),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                foregroundImage: NetworkImage(
                                    'https://avatars.githubusercontent.com/u/63546159?v=4'),
                              ),
                              title: Text(
                                'Cenk Duran',
                              ),
                              subtitle: Text(
                                'Working at Starbucks, London',
                              ),
                            ),
                            //send message ListTile
                            ListTile(
                              leading: Icon(
                                Icons.message,
                              ),
                              title: Text(
                                'Send Message',
                              ),
                            ),
                            //get directions ListTile
                            ListTile(
                              leading: Icon(
                                Icons.directions,
                              ),
                              title: Text(
                                'Get Directions',
                              ),
                              onTap: () async {
                                final availableMaps =
                                    await MapLauncher.installedMaps;

                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoActionSheet(
                                        title: Text('Get Directions'),
                                        actions: [
                                          CupertinoActionSheetAction(
                                            onPressed: () {
                                              MapLauncher.showDirections(
                                                mapType: MapType.apple,
                                                destination: Coords(
                                                  51.5,
                                                  -0.09,
                                                ),
                                                destinationTitle: "London",
                                              );
                                              MapLauncher.showMarker(
                                                  title: "London",
                                                  mapType: MapType.apple,
                                                  coords: Coords(
                                                    51.5,
                                                    -0.09,
                                                  ));
                                            },
                                            child: Text('Open in Maps'),
                                          ),
                                          CupertinoActionSheetAction(
                                            onPressed: () {
                                              MapLauncher.showDirections(
                                                mapType: MapType.google,
                                                destination: Coords(
                                                  51.5,
                                                  -0.09,
                                                ),
                                                destinationTitle: "London",
                                              );
                                              MapLauncher.showMarker(
                                                  title: "London",
                                                  mapType: MapType.google,
                                                  coords: Coords(
                                                    51.5,
                                                    -0.09,
                                                  ));
                                            },
                                            child: Text('Open in Google Maps'),
                                          ),
                                        ],
                                        cancelButton:
                                            CupertinoActionSheetAction(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel')),
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 30,
                  foregroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/63546159?v=4'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
