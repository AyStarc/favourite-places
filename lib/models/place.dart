import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation(this.latitude, this.longitude,this.address);
  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  Place(this.title, this.img, this.location) : id = uuid.v4();

  final String id;
  final String title;
  final File img;
  final PlaceLocation location;
}
