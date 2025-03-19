import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:studio_partner_app/commons/views/widgets/custom_appbar.dart';
import 'package:studio_partner_app/src/feature/Home/controller/studio_list_controller.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/select_map.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/add_image.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/chip_selection.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/label_title.dart';
import 'package:studio_partner_app/src/feature/file/controller/studiofile.dart';
import 'package:studio_partner_app/src/models/studio_model.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import '../controller/studio_controller.dart';
import 'widgets/custom_textfield.dart';
import 'widgets/facilities_chip.dart';
import 'widgets/request_button.dart';

class Rent extends ConsumerStatefulWidget {
  final Studio? studio;
  final bool? disableTextField, isEdit;
  const Rent(
      {super.key,
      this.studio,
      this.disableTextField = false,
      this.isEdit = false});

  @override
  ConsumerState<Rent> createState() => _RentState();
}

class _RentState extends ConsumerState<Rent> {
  final List<String> categories = [
    'Photography',
    'Videography',
    'Music Recording',
    'Dance',
    'Art & Craft',
    'Fitness',
    'Meeting',
    'Event',
    'Office',
    'Coworking & Content Creation'
  ];
  List<String> selectedFacilities = [];
  final Map<String, List<String>> propertyFacilities = {
    'Photography': [
      'WiFi',
      'Air Conditioner',
      'Lighting Setup',
      'Tripod',
      'Backdrops',
      'Camera Rental',
      'Makeup Room',
      'Power Backup'
    ],
    'Videography': [
      'WiFi',
      'Security',
      'Lighting Setup',
      'Tripod',
      'Green Screen',
      'Soundproofing',
      'Editing Desk',
      'Drone Access'
    ],
    'Music Recording': [
      'WiFi',
      'Air Conditioner',
      'Soundproofing',
      'Mixer',
      'Microphones',
      'Headphones',
      'Live Recording',
      'Instrument Rental'
    ],
    'Dance': [
      'WiFi',
      'Air Conditioner',
      'Mirrors',
      'Music System',
      'Wooden Flooring',
      'Changing Rooms',
      'CCTV Security',
      'First Aid Kit'
    ],
    'Art & Craft': [
      'WiFi',
      'Free Parking',
      'Storage Space',
      'Art Supplies',
      'Natural Lighting',
      'Workshop Area',
      'Craft Tools',
      'Security Surveillance'
    ],
    'Fitness': [
      'WiFi',
      'Free Parking',
      'Locker Rooms',
      'Gym Equipment',
      'Showers',
      'Yoga Mats',
      'Personal Trainers',
      '24/7 Access'
    ],
    'Meeting': [
      'WiFi',
      'Projector',
      'Air Conditioner',
      'Whiteboard',
      'Conference Calling',
      'Soundproofing',
      'Office Supplies',
      'Tea/Coffee Station'
    ],
    'Event': [
      'WiFi',
      'Security',
      'Free Parking',
      'Stage Setup',
      'Catering Services',
      'VIP Seating',
      'Live Streaming',
      'Emergency Exits'
    ],
    'Office': [
      'WiFi',
      'Air Conditioner',
      'Security',
      'Meeting Room',
      'Printer/Scanner',
      'Desk Space',
      'Pantry',
      'CCTV Surveillance'
    ],
    'Coworking & Content Creation': [
      'WiFi',
      'Self Check-in',
      '24/7 Access',
      'Coffee Machine',
      'Podcast Studio',
      'Video Editing Suite',
      'Private Cabins',
      'Printing & Scanning'
    ],
  };

  late TextEditingController _studioNameController,
      _aboutStudioController,
      _floorController,
      _addressLine1Controller,
      _cityController,
      _stateController,
      _pincodeController,
      _countryController,
      _areaSqFtController,
      _basePricePerHourController,
      _fullPricePerDayController,
      _equipmentChargesController,
      _securityDepositeController,
      _cleaningChargesController;
  LatLng? selectedLocation;
  List<Widget>? addons = [];
  File? _thumbnailFile;
  List<Price>? _price;
  List<File> _multipleFiles = [];
  List<File> _multipleVideos = [];
  List<String> _videoUrls = [];
  List<String> _imageUrls = [];
  bool _isDropdownOpen = false;
  String _selectedType = "Select Type";
  String _selectedCategory = 'Photography';

  void _pickThumbnail() async {
    final controller = ref.read(studioFileControllerProvider);
    final file = await controller.selectFile();
    if (file != null) {
      setState(() {
        _thumbnailFile = file;
      });
      log('Thumbnail file: $_thumbnailFile');
    }
  }

  void _pickMultipleImages() async {
    final controller = ref.read(studioFileControllerProvider);
    final result = await controller.selectMultipleFiles();
    if (result != null && result.isNotEmpty) {
      setState(() {
        _multipleFiles = result;
      });
    }
  }

  Future<void> _pickMultipleVideos() async {
    final controller = ref.read(studioFileControllerProvider);
    final result = await controller.selectMultipleFiles(allowVideo: true);
    print("Result pick videos : $result");
    if (result != null && result.isNotEmpty) {
      setState(() {
        _multipleVideos.addAll(result);
      });
      final firstVideo = result.first;
      final data = await controller.uploadStudioVideos(
        videos: firstVideo,
        ref: ref,
      );
      setState(() {
        _videoUrls.add(data.toString());
      });
      print("Uploaded video file: $data");
    }
  }

  void _removeImage(int index, bool isFile) {
    setState(() {
      if (isFile) {
        _multipleFiles.removeAt(index);
      } else {
        _imageUrls.removeAt(index);
      }
    });
  }

  void _removeVideo(int index, bool isFile) {
    setState(() {
      if (isFile) {
        _multipleVideos.removeAt(index);
      } else {
        _videoUrls.removeAt(index);
      }
    });
  }

  @override
  void initState() {
    _studioNameController = TextEditingController();
    _aboutStudioController = TextEditingController();
    _floorController = TextEditingController();
    _addressLine1Controller = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _pincodeController = TextEditingController();
    _countryController = TextEditingController();
    _areaSqFtController = TextEditingController();
    _basePricePerHourController = TextEditingController();
    _fullPricePerDayController = TextEditingController();
    _equipmentChargesController = TextEditingController();
    _securityDepositeController = TextEditingController();
    _cleaningChargesController = TextEditingController();
    if (widget.studio != null) {
      _selectedType = widget.studio!.type!;
      selectedLocation = LatLng(widget.studio!.location!.coordinates![1],
          widget.studio!.location!.coordinates![0]);
      _studioNameController.text = widget.studio!.name!;
      _aboutStudioController.text = widget.studio!.about!;
      _addressLine1Controller.text = widget.studio!.address!;
      _cityController.text = widget.studio!.city!;
      _stateController.text = widget.studio!.state!;
      _countryController.text = widget.studio!.country!;
      _pincodeController.text = widget.studio!.pincode!;
      _areaSqFtController.text = widget.studio!.areaSqFt!;
      _selectedCategory = widget.studio!.category!;
      selectedFacilities = widget.studio!.facility!;
      _imageUrls = List.from(widget.studio!.images!);
      _videoUrls = List.from(widget.studio!.videos!);
      _basePricePerHourController.text =
          widget.studio!.basePricePerHour?.toString() ?? '';

      _fullPricePerDayController.text =
          widget.studio!.fullPricePerDay?.toString() ?? '';
      _equipmentChargesController.text =
          widget.studio!.equipmentCharges?.toString() ?? '';
      _securityDepositeController.text =
          widget.studio!.securityDeposit?.toString() ?? '';
      _cleaningChargesController.text =
          widget.studio!.cleaningCharges?.toString() ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> facilities = propertyFacilities[_selectedCategory] ?? [];
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: (widget.disableTextField! || widget.isEdit!)
          ? const CustomAppBar(title: 'Studio')
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: AddImage(
                    imageUrl: widget.isEdit! || widget.disableTextField!
                        ? widget.studio!.thumbnail!
                        : null,
                    onTap: () {
                      widget.disableTextField! ? null : _pickThumbnail();
                    },
                    image: _thumbnailFile,
                  ),
                ),
                widget.disableTextField!
                    ? const SizedBox()
                    : Center(
                        child: Text(
                          widget.isEdit! ? 'Edit Thumbnail' : 'Add Thumbnail',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                const SizedBox(height: 8),
                Text(
                  'Studio Name',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                CustomTextField(
                  disableTextField: widget.disableTextField!,
                  controller: _studioNameController,
                  hintText: 'Studio Name*',
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDropdownOpen = !_isDropdownOpen;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFF4F6F9),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedType,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    if (_isDropdownOpen)
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.grey, width: 1),
                            right: BorderSide(color: Colors.grey, width: 1),
                            bottom: BorderSide(color: Colors.grey, width: 1),
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              minTileHeight: 20,
                              title: Text(
                                'Commercial',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedType = 'Commercial';
                                  _isDropdownOpen = false;
                                });
                              },
                            ),
                            ListTile(
                              minTileHeight: 20,
                              title: Text(
                                'Residential',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedType = 'Residential';
                                  _isDropdownOpen = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Category',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ChipSelection(
                  categories: categories,
                  onCategorySelected: (category) {
                    widget.disableTextField!
                        ? null
                        : setState(() {
                            _selectedCategory = category;
                          });
                  },
                  selectedCategory: _selectedCategory,
                ),
                const SizedBox(height: 8),
                Text(
                  'About Studio',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                CustomTextField(
                  disableTextField: widget.disableTextField!,
                  controller: _aboutStudioController,
                  maxLines: 4,
                  hintText: 'About Studio',
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Address',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    widget.disableTextField!
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () async {
                              setState(() {
                                selectedLocation = null;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const GoogleMapFlutter(),
                                ),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    selectedLocation = value['location'];
                                    _floorController.text =
                                        value['street'] ?? '';
                                    _addressLine1Controller.text =
                                        value['area'] ?? '';
                                    _cityController.text = value['city'] ?? '';
                                    _stateController.text =
                                        value['state'] ?? '';
                                    _countryController.text =
                                        value['country'] ?? '';
                                    _pincodeController.text =
                                        value['pincode'] ?? '';
                                  });
                                  print(
                                      "Selected Location: ${value['location']}");
                                  print(
                                      "Selected Address: ${value['address']}");
                                }
                              });
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.primaryBackgroundColor,
                                  size: 20,
                                ),
                                Text(
                                  'Select From Maps',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.primaryBackgroundColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),

                selectedLocation != null
                    ? Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: selectedLocation != null
                                  ? selectedLocation!
                                  : const LatLng(0.0, 0.0),
                              zoom: 14.0, // Set zoom level
                            ),
                            markers: {
                              Marker(
                                markerId: const MarkerId('selected-location'),
                                position: selectedLocation != null
                                    ? selectedLocation!
                                    : const LatLng(0.0, 0.0),
                              ),
                            },
                            zoomControlsEnabled: false,
                            scrollGesturesEnabled: false,
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 8),
                CustomTextField(
                  disableTextField: widget.disableTextField!,
                  controller: _floorController,
                  icon: Icons.business,
                  hintText: 'Floar/Building Number',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  disableTextField: widget.disableTextField!,
                  controller: _addressLine1Controller,
                  icon: Icons.location_on_outlined,
                  hintText: 'Address Line 1',
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        disableTextField: widget.disableTextField!,
                        controller: _cityController,
                        icon: Icons.location_city,
                        hintText: 'City',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextField(
                        disableTextField: widget.disableTextField!,
                        controller: _stateController,
                        icon: Icons.location_city,
                        hintText: 'State',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        disableTextField: widget.disableTextField!,
                        controller: _pincodeController,
                        icon: Icons.location_city,
                        hintText: 'Pincode',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextField(
                        disableTextField: widget.disableTextField!,
                        controller: _countryController,
                        icon: Icons.location_city,
                        hintText: 'Country',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Text(
                  'Area(Sq. Ft)',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                CustomTextField(
                  disableTextField: widget.disableTextField!,
                  controller: _areaSqFtController,
                  hintText: 'Area(Sq. Ft)',
                ),
                const SizedBox(height: 10),
                Text(
                  'Facilities',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children: facilities.map((facility) {
                    bool isSelected = selectedFacilities.contains(facility);
                    return FacilitiesChip(
                      isSelected: isSelected,
                      onTap: () {
                        if (!widget.disableTextField!) {
                          setState(() {
                            isSelected
                                ? selectedFacilities.remove(facility)
                                : selectedFacilities.add(facility);
                          });
                        }
                      },
                      label: facility,
                    );
                  }).toList(),
                ),

                // ###########################  Add Images ########################
                Row(
                  children: [
                    widget.disableTextField! || widget.isEdit!
                        ? const CustomLabelTitle(title: "Images")
                        : _multipleFiles.isEmpty
                            ? const CustomLabelTitle(title: "Add Images")
                            : const CustomLabelTitle(title: "Images"),
                    const Spacer(),
                    if (_multipleFiles.isNotEmpty || widget.isEdit!)
                      TextButton(
                        onPressed: _pickMultipleImages,
                        child: const Text(
                          'Add More Images',
                          style: TextStyle(
                              color: AppColors.primaryBackgroundColor),
                        ),
                      ),
                  ],
                ),
                (widget.disableTextField! || widget.isEdit!) &&
                        _multipleFiles.isNotEmpty
                    ? MultipleImagesDisplay(
                        imageFiles: _multipleFiles,
                        imageUrls: _imageUrls,
                        onRemove: _removeImage,
                      )
                    : widget.disableTextField!
                        ? MultipleImagesDisplay(
                            imageUrls: _imageUrls,
                          )
                        : widget.isEdit!
                            ? MultipleImagesDisplay(
                                imageUrls: _imageUrls,
                                onRemove: _removeImage,
                              )
                            : _multipleFiles.isNotEmpty
                                ? MultipleImagesDisplay(
                                    imageFiles: _multipleFiles,
                                    onRemove: _removeImage,
                                  )
                                : InkWell(
                                    onTap: () {
                                      _pickMultipleImages();
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              130, 130, 130, 1),
                                        ),
                                      ),
                                      child: const Image(
                                        image: AssetImage(
                                          "assets/images/add_image.png",
                                        ),
                                      ),
                                    ),
                                  ),
                // ########################### Add Videos ######################
                Row(
                  children: [
                    const CustomLabelTitle(title: "Videos"),
                    const Spacer(),
                    if (!widget.disableTextField!)
                      TextButton(
                        onPressed: _pickMultipleVideos,
                        child: const Text(
                          'Upload Videos',
                          style: TextStyle(
                              color: AppColors.primaryBackgroundColor),
                        ),
                      ),
                  ],
                ),

                if (_multipleVideos.isNotEmpty ||
                    widget.isEdit! ||
                    widget.disableTextField!)
                  MultipleVideosDisplay(
                    videoFiles: null,
                    videoUrls: _videoUrls,
                    onRemove: widget.disableTextField! ? null : _removeVideo,
                  )
                else
                  InkWell(
                    onTap: _pickMultipleVideos,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color.fromRGBO(130, 130, 130, 1),
                        ),
                      ),
                      child: const Icon(
                        Icons.video_file_outlined,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                // ###########################  Pricing ########################
                const SizedBox(height: 10),
                Text(
                  'Base Price',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomTextField(
                  disableTextField: widget.disableTextField!,
                  controller: _basePricePerHourController,
                  suffixLabel: 'Per Hour',
                  icon: Icons.currency_rupee,
                  hintText: 'Base Price Per Hour',
                ),
                const SizedBox(height: 5),
                Text(
                  'Full Day Price (8 hours)',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomTextField(
                  disableTextField: widget.disableTextField!,
                  controller: _fullPricePerDayController,
                  suffixLabel: 'Per Day',
                  icon: Icons.currency_rupee,
                  hintText: 'Full Day Price (8 hours)',
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Equipment Charges (Optional)',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomTextField(
                  disableTextField: widget.disableTextField!,
                  controller: _equipmentChargesController,
                  icon: Icons.currency_rupee,
                  hintText: 'Equipment Charges',
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Security Deposit',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomTextField(
                  disableTextField: widget.disableTextField!,
                  controller: _securityDepositeController,
                  icon: Icons.currency_rupee,
                  hintText: 'Security Deposit',
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Cleaning Charges',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomTextField(
                  disableTextField: widget.disableTextField!,
                  controller: _cleaningChargesController,
                  icon: Icons.currency_rupee,
                  hintText: 'Cleaning Charges',
                ),
                if (widget.disableTextField!)
                  const SizedBox(
                    height: 10,
                  ),
                if (!widget.disableTextField! || widget.isEdit!)
                  AddStudioRequestButton(
                    label: widget.isEdit! ? 'Update Studio' : 'Add Studio',
                    onTap: () {
                      log('thumbnail: $_thumbnailFile');
                      Location locationFromLatLng(LatLng? selectedLocation) {
                        if (selectedLocation != null) {
                          return Location(
                            type: 'Point',
                            coordinates: [
                              selectedLocation.longitude,
                              selectedLocation.latitude
                            ],
                          );
                        }
                        return Location(type: 'Point', coordinates: []);
                      }

                      final updatedProfile = Studio(
                        name: _studioNameController.text,
                        type: _selectedType,
                        about: _aboutStudioController.text,
                        address: _addressLine1Controller.text,
                        city: _cityController.text,
                        state: _stateController.text,
                        pincode: _pincodeController.text,
                        areaSqFt: _areaSqFtController.text,
                        country: _countryController.text,
                        location: locationFromLatLng(selectedLocation),
                        category: _selectedCategory,
                        facility: selectedFacilities,
                        rentOrSell: 'Rent',
                        price: _price,
                        basePricePerHour:
                            int.tryParse(_basePricePerHourController.text) ?? 0,
                        fullPricePerDay:
                            int.tryParse(_fullPricePerDayController.text) ?? 0,
                        equipmentCharges:
                            int.tryParse(_equipmentChargesController.text) ?? 0,
                        securityDeposit:
                            int.tryParse(_securityDepositeController.text) ?? 0,
                        cleaningCharges:
                            int.tryParse(_cleaningChargesController.text) ?? 0,
                        images: _imageUrls,
                        videos: _videoUrls,
                      );
                      widget.studio != null
                          ? ref
                              .read(studioListControllerProvider.notifier)
                              .updateStudio(
                                studioId: widget.studio!.id!,
                                studio: updatedProfile,
                                context: context,
                                thumbnailFile: _thumbnailFile,
                                imageUrl: _imageUrls,
                                imageFiles: _multipleFiles,
                              )
                          : ref
                              .read(studioControllerProvider.notifier)
                              .addNewStudio(
                                context: context,
                                studio: updatedProfile,
                                thumbnail: _thumbnailFile,
                                images: _multipleFiles,
                              );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
