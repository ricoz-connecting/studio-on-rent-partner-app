import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Main widget for displaying Google Map
class GoogleMapFlutter extends StatefulWidget {
  const GoogleMapFlutter({super.key});

  @override
  State<GoogleMapFlutter> createState() => _GoogleMapFlutterState();
}

class _GoogleMapFlutterState extends State<GoogleMapFlutter> {
  LatLng myCurrentLocation = const LatLng(0, 0);
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    // Fetch the current position when the widget is initialized
    fetchCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Select Location',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: CameraPosition(
              target: myCurrentLocation,
              zoom: 14,
            ),
            onTap: (LatLng latLng) {
              _addMarker(latLng);
            },
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              heroTag: 'currentLocation',
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.my_location,
                size: 25,
              ),
              onPressed: () async {
                Position position = await currentPosition();
                final controller = await _controller.future;
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 14,
                    ),
                  ),
                );
                _addMarker(LatLng(position.latitude, position.longitude));
              },
            ),
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            child: FloatingActionButton(
              heroTag: 'confirmLocation',
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.check,
                size: 25,
              ),
              onPressed: () {
                if (selectedLocation != null) {
                  Navigator.pop(context, selectedLocation);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select a location on the map."),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addMarker(LatLng latLng) {
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: latLng,
        ),
      );
      selectedLocation = latLng;

      log('Selected location: Latitude: ${latLng.latitude}, Longitude: ${latLng.longitude}');
    });
  }

  Future<Position> currentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> fetchCurrentLocation() async {
    try {
      Position position = await currentPosition();
      setState(() {
        myCurrentLocation = LatLng(position.latitude, position.longitude);
        selectedLocation = myCurrentLocation;
        markers.add(
          Marker(
            markerId: const MarkerId('initialLocation'),
            position: myCurrentLocation,
          ),
        );
      });
      final controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: myCurrentLocation,
            zoom: 14,
          ),
        ),
      );
    } catch (e) {
      log('Error fetching location: $e');
    }
  }
}

//   void _addMarker(LatLng latLng) {
//     setState(() {
//       markers.clear();
//       markers.add(
//         Marker(
//           markerId: const MarkerId('selectedLocation'),
//           position: latLng,
//         ),
//       );
//       selectedLocation = latLng;

//       log('Selected location: Latitude: ${latLng.latitude}, Longitude: ${latLng.longitude}');
//     });
//   }
// }
