import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import '../models/place.dart';

class LocationInput extends StatefulWidget {
  const LocationInput(
      {super.key,
      required this.onPickLocation}); // const LocationInput(this.onPickLocation, {super.key});

  final void Function(PlaceLocation location) onPickLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? pickedLocation;
  bool isGettingLocation = false;

  String locationImage() {
    final latitude = pickedLocation!.latitude;
    final longitude = pickedLocation!.longitude;
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap &markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318 &markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=YOUR_API_KEY&signature=YOUR_SIGNATURE";
  }

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    // can do error handling
    if (latitude == null || longitude == null) {
      return;
    }

    print(latitude);
    print(longitude);

    String url = "http://api.positionstack.com/v1/reverse?access_key=1e79cb4dad4de1fdfdeb3f1d46160cd2&query=26.8467,80.9462";

    http.Response response = await http.get(Uri.parse(url)); // response is of the JSON format
    print(response.statusCode);
    final resData = json.decode(response.body); // resData now a Dart Map
    print(resData);
    print(resData['data']);
    final address = resData['data'];

    setState(() {
      pickedLocation = PlaceLocation(latitude, longitude, address);
      isGettingLocation = false;
    });

    widget.onPickLocation(pickedLocation!);
  }

  @override
  Widget build(BuildContext context) {
    Widget preview = Text(
      "Choose a Location",
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (pickedLocation != null) {
      preview = Image.network(locationImage());
    }

    if (isGettingLocation) {
      preview = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
          height: 160,
          width: double.infinity,
          alignment: Alignment.center,
          child: preview,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: () {
                  getCurrentLocation();
                },
                icon: const Icon(Icons.location_on),
                label: const Text("Get Current Location")),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: const Text("Choose Location on Map"))
          ],
        )
      ],
    );
  }
}
