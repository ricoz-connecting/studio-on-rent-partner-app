import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/select_map.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/add_image.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/chip_selection.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/label_title.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/rental_widget.dart';
import 'package:studio_partner_app/src/feature/file/controller/studiofile.dart';
import 'package:studio_partner_app/src/models/studio_model.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import '../controller/studio_controller.dart';
import 'widgets/custom_textfield.dart';
import 'widgets/facilities_chip.dart';
import 'widgets/request_button.dart';

class Rent extends ConsumerStatefulWidget {
  const Rent({super.key});

  @override
  ConsumerState<Rent> createState() => _RentState();
}

class _RentState extends ConsumerState<Rent> {
  final List<String> categories = [
    'Recording',
    'Photography',
    'Misc.',
    'Luxury',
  ];
  LatLng? selectedLocation;
  List<String>? facilities = [];
  List<Widget>? addons = [];
  File? _thumbnailFile;
  final List<Price> _price = [];
  List<File> _multipleFiles = [];
  final _selectedLocationNotifier = ValueNotifier<LatLng?>(null);
  String _selectedType = 'Commercial';
  String _selectedCategory = 'Recording';
  String? _studioName,
      _aboutStudio,
      _addressLine1,
      _city,
      _state,
      _pincode,
      _areaSqFt,
      _basePriceMonth,
      _basePriceDay,
      _basePriceWeek;

  bool isAnySelected = false,
      isWifiSelected = false,
      isSelfCheckInSelected = false,
      isTimeSelected = false,
      isFreeCancelSelected = false,
      isFreeParkingSelected = false,
      isSecuritySelected = false,
      isMembersSelected = false,
      isAirConditionerSelected = false;

  void _pickThumbnail() async {
    final controller = ref.read(studioFileControllerProvider);
    final file = await controller.selectFile();
    if (file != null) {
      setState(() {
        _thumbnailFile = file;
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: AddImage(
                    onTap: () {
                      _pickThumbnail();
                    },
                    image: _thumbnailFile,
                  ),
                ),
                Center(
                  child: Text(
                    'Add Thumbnail',
                    style: GoogleFonts.inter(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  onChanged: (value) {
                    setState(() {
                      _studioName = value;
                    });
                  },
                  hintText: 'Studio Name*',
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Type',
                      style: GoogleFonts.inter(fontSize: 16),
                    ),
                    const Spacer(),
                    DropdownButton<String>(
                      value: _selectedType,
                      items: <String>['Commercial', 'Residential']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                      hint: const Text('Select Type'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Category',
                  style: GoogleFonts.inter(fontSize: 16),
                ),
                const SizedBox(height: 10),
                ChipSelection(
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  onChanged: (value) {
                    setState(() {
                      _aboutStudio = value;
                    });
                  },
                  height: 100,
                  hintText: 'About Studio',
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLocation = null;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GoogleMapFlutter(),
                      ),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          selectedLocation = value;
                        });
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Address',
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.primaryBackgroundColor,
                      ),
                      const Text(
                        'Select From Maps',
                        style:
                            TextStyle(color: AppColors.primaryBackgroundColor),
                      ),
                    ],
                  ),
                ),
                selectedLocation != null
                    ? Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F6F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                            target: selectedLocation!,
                            zoom: 14,
                          )),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 10),
                CustomTextField(
                  onChanged: (value) {
                    setState(() {
                      _addressLine1 = value;
                    });
                  },
                  icon: Icons.location_on_outlined,
                  hintText: 'Address Line 1',
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        onChanged: (value) {
                          setState(() {
                            _city = value;
                          });
                        },
                        icon: Icons.location_on_outlined,
                        hintText: 'City',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextField(
                        onChanged: (value) {
                          setState(() {
                            _state = value;
                          });
                        },
                        icon: Icons.location_on_outlined,
                        hintText: 'State',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  onChanged: (value) {
                    setState(() {
                      _pincode = value;
                    });
                  },
                  icon: Icons.location_on_outlined,
                  hintText: 'Pincode',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  onChanged: (value) {
                    setState(() {
                      _areaSqFt = value;
                    });
                  },
                  icon: Icons.location_on_outlined,
                  hintText: 'Area(Sq. Ft)',
                ),
                const SizedBox(height: 10),
                Text(
                  'Property Facilities',
                  style: GoogleFonts.inter(fontSize: 16),
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    FacilitiesChip(
                      isSelected: isAnySelected,
                      onTap: () {
                        setState(() {
                          isAnySelected = !isAnySelected;
                          isAnySelected
                              ? facilities?.add('Any')
                              : facilities?.remove('Any');
                        });
                      },
                      label: 'Any',
                    ),
                    FacilitiesChip(
                      isSelected: isWifiSelected,
                      onTap: () {
                        setState(() {
                          isWifiSelected = !isWifiSelected;
                          isWifiSelected
                              ? facilities?.add('WiFi')
                              : facilities?.remove('WiFi');
                        });
                      },
                      label: 'WiFi',
                    ),
                    FacilitiesChip(
                      isSelected: isSelfCheckInSelected,
                      onTap: () {
                        setState(() {
                          isSelfCheckInSelected = !isSelfCheckInSelected;
                          isSelfCheckInSelected
                              ? facilities?.add('Self check-in')
                              : facilities?.remove('Self check-in');
                        });
                      },
                      label: 'Self check-in',
                    ),
                    FacilitiesChip(
                      isSelected: isTimeSelected,
                      onTap: () {
                        setState(() {
                          isTimeSelected = !isTimeSelected;
                          isTimeSelected
                              ? facilities?.add('time')
                              : facilities?.remove('time');
                        });
                      },
                      label: 'time',
                    ),
                    FacilitiesChip(
                      isSelected: isFreeCancelSelected,
                      onTap: () {
                        setState(() {
                          isFreeCancelSelected = !isFreeCancelSelected;
                          isFreeCancelSelected
                              ? facilities?.add('Free cancel')
                              : facilities?.remove('Free cancel');
                        });
                      },
                      label: 'Free cancel',
                    ),
                    FacilitiesChip(
                      isSelected: isSecuritySelected,
                      onTap: () {
                        setState(() {
                          isSecuritySelected = !isSecuritySelected;
                          isSecuritySelected
                              ? facilities?.add('Security')
                              : facilities?.remove('Security');
                        });
                      },
                      label: 'Security',
                    ),
                    FacilitiesChip(
                      isSelected: isMembersSelected,
                      onTap: () {
                        setState(() {
                          isMembersSelected = !isMembersSelected;
                          isMembersSelected
                              ? facilities?.add('Members')
                              : facilities?.remove('Members');
                        });
                      },
                      label: 'Members',
                    ),
                    FacilitiesChip(
                      isSelected: isFreeParkingSelected,
                      onTap: () {
                        setState(() {
                          isFreeParkingSelected = !isFreeParkingSelected;
                          isFreeParkingSelected
                              ? facilities?.add('Free Parking')
                              : facilities?.remove('Free Parking');
                        });
                      },
                      label: 'Free Parking',
                    ),
                    FacilitiesChip(
                      isSelected: isAirConditionerSelected,
                      onTap: () {
                        setState(() {
                          isAirConditionerSelected = !isAirConditionerSelected;
                          isAirConditionerSelected
                              ? facilities?.add('Air Conditioner')
                              : facilities?.remove('Air Conditioner');
                        });
                      },
                      label: 'Air Conditioner',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _multipleFiles.isEmpty
                        ? const CustomLabelTitle(title: "Add Images")
                        : const CustomLabelTitle(title: "Images"),
                    const Spacer(),
                    if (_multipleFiles.isNotEmpty)
                      TextButton(
                          onPressed: _pickMultipleImages,
                          child: const Text('Add More Images',
                              style: TextStyle(
                                  color: AppColors.primaryBackgroundColor))),
                  ],
                ),
                _multipleFiles.isNotEmpty
                    ? MultipleImagesDisplay(imageFiles: _multipleFiles)
                    : InkWell(
                        onTap: () {
                          _pickMultipleImages();
                        },
                        child: Container(
                          height: 84,
                          width: 84,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromRGBO(130, 130, 130, 1),
                            ),
                          ),
                          child: const Image(
                            image: AssetImage("assets/images/add_image.png"),
                          ),
                        ),
                      ),
                const SizedBox(height: 10),
                Text(
                  'Pricing',
                  style: GoogleFonts.inter(fontSize: 16),
                ),
                const SizedBox(height: 10),
                const RentalWidget(
                  label: "Rental",
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  onChanged: (value) {
                    setState(() {
                      _basePriceMonth = value;
                    });
                  },
                  suffixLabel: '/Per month',
                  icon: Icons.price_change_outlined,
                  hintText: 'Base Price',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  onChanged: (value) {
                    setState(() {
                      _basePriceDay = value;
                    });
                  },
                  suffixLabel: '/Per day',
                  icon: Icons.price_change_outlined,
                  hintText: 'Base Price',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  onChanged: (value) {
                    setState(() {
                      _basePriceWeek = value;
                    });
                  },
                  suffixLabel: '/Per week',
                  icon: Icons.price_change_outlined,
                  hintText: 'Base Price',
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: AddStudioRequestButton(
        onTap: () {
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

          if (_basePriceDay != null) {
            _price.add(Price(
                title: 'Daily Rent',
                amount: int.parse(_basePriceDay!),
                discount: 0));
          }
          if (_basePriceMonth != null) {
            _price.add(Price(
                title: 'Monthly Rent',
                amount: int.parse(_basePriceMonth!),
                discount: 0));
          }
          if (_basePriceWeek != null) {
            _price.add(Price(
                title: 'Weekly Rent',
                amount: int.parse(_basePriceWeek!),
                discount: 0));
          }
          final updatedProfile = Studio(
            name: _studioName,
            about: _aboutStudio,
            address: _addressLine1,
            city: _city,
            state: _state,
            pincode: _pincode,
            areaSqFt: _areaSqFt,
            country: "india",
            location: locationFromLatLng(selectedLocation),
            category: _selectedCategory,
            facility: facilities,
            rentOrSell: 'Rent',
            price: _price,
          );
          ref.read(studioControllerProvider.notifier).addNewStudio(
                context: context,
                studio: updatedProfile,
                thumbnail: _thumbnailFile,
                images: _multipleFiles,
              );
        },
      ),
    );
  }
}
