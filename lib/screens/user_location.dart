import 'package:flutter/material.dart';
import 'package:location/location.dart';

class UserLocation extends StatefulWidget {
  const UserLocation({super.key});

  @override
  State<UserLocation> createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  String? previewImage;

  Future<void> _getUserLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    print(locationData.latitude);
    print(locationData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: previewImage == null
              ? const Center(child: Text("No location added yet"))
              : Image.network(previewImage!),
        ),
        Row(
          children: [
            TextButton.icon(
                icon: const Icon(Icons.location_on),
                label: const Text("select on map"),
                onPressed: () => _getUserLocation()),
            TextButton.icon(
                icon: const Icon(Icons.map),
                label: const Text("Select on Map"),
                onPressed: () {})
          ],
        )
      ],
    );
  }
}
