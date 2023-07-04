import 'package:flutter/material.dart';
import 'package:one_favorite_places/models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.location = const PlaceLocation(37.422, -122.084, "")});

  final PlaceLocation location;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ,
    );
  }
}
