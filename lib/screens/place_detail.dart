import 'package:flutter/material.dart';

import 'package:one_favorite_places/models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  PlaceDetailScreen({super.key, required this.place});

  final Place place;

  String locationImage() {
    final lat = place.location.latitude;
    final lng = place.location.longitude;
    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap &markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318 &markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=YOUR_API_KEY&signature=YOUR_SIGNATURE";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        body: Stack(
          children: [
            Image.file(
              place.img,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: Column(
                  children: [
                    CircleAvatar(
                        backgroundImage: NetworkImage(locationImage())),
                    Text(place.location.address)
                  ],
                ))
          ],
        ));
  }
}
