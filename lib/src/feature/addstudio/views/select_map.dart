import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class GoogleMapFlutter extends StatefulWidget {
  const GoogleMapFlutter({super.key});

  @override
  State<GoogleMapFlutter> createState() => _GoogleMapFlutterState();
}

class _GoogleMapFlutterState extends State<GoogleMapFlutter> {
  LatLng myCurrentLocation = const LatLng(0, 0);
  bool isLoadingAddress = false;
  String? fetchedAddress;
  Placemark? selectedPlacemark;
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    fetchCurrentLocation();
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address = '''${place.street ?? ''},
${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}, ${place.postalCode ?? ''}
''';
        setState(() {
          fetchedAddress = address;
          selectedPlacemark = place;
          isLoadingAddress = false;
        });
        log('Fetched Address: $address');
      } else {
        setState(() {
          fetchedAddress = 'No address found';
          isLoadingAddress = false;
        });
      }
    } catch (e) {
      setState(() {
        fetchedAddress = 'Error fetching address';
        isLoadingAddress = false;
      });
      log('Error in address fetch: $e');
    }
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
            bottom: 100,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: isLoadingAddress
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      fetchedAddress ?? 'Tap on the map to select a location',
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
            ),
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
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: FloatingActionButton(
          heroTag: 'confirmLocation',
          backgroundColor: AppColors.primaryBackgroundColor,
          child: Text(
            'Select Address ',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            if (selectedLocation != null && selectedPlacemark != null) {
              Navigator.pop(context, {
                'location': selectedLocation,
                'street': selectedPlacemark!.street!,
                'area': selectedPlacemark!.subLocality!,
                'state': selectedPlacemark!.administrativeArea!,
                'city': selectedPlacemark!.locality!,
                'pincode': selectedPlacemark!.postalCode!,
                'country': selectedPlacemark!.country!,
              });
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
      isLoadingAddress = true;

      log('Selected location: Latitude: ${latLng.latitude}, Longitude: ${latLng.longitude}');
      // Fetch and display the address
    });
    _getAddressFromLatLng(latLng);
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
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address = '''${place.street ?? ''},
${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}, ${place.postalCode ?? ''}
''';
        setState(() {
          selectedPlacemark = place;
          fetchedAddress = address;
          isLoadingAddress = false;
        });
      }
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
