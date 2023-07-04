import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:one_favorite_places/models/place.dart';
import 'package:one_favorite_places/widgets/input_location.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File img, PlaceLocation location) {
    final newPlace = Place(title, img, location);
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
