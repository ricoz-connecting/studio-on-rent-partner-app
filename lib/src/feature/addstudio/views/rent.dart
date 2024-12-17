import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:studio_partner_app/src/feature/Home/controller/studio_list_controller.dart';
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
    'Recording',
    'Photography',
    'Misc.',
    'Luxury',
  ];
  late TextEditingController _studioNameController,
      _aboutStudioController,
      _addressLine1Controller,
      _cityController,
      _stateController,
      _pincodeController,
      _areaSqFtController,
      _basePriceMonthController,
      _basePriceDayController,
      _basePriceWeekController;
  LatLng? selectedLocation;
  List<String>? facilities = List<String>.empty(growable: true);
  List<Widget>? addons = [];
  File? _thumbnailFile;
  List<Price>? _price;
  List<File> _multipleFiles = [];
  String _selectedType = 'Commercial';
  String _selectedCategory = 'Recording';
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

  @override
  void initState() {
    _studioNameController = TextEditingController();
    _aboutStudioController = TextEditingController();
    _addressLine1Controller = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _pincodeController = TextEditingController();
    _areaSqFtController = TextEditingController();
    _basePriceMonthController = TextEditingController();
    _basePriceDayController = TextEditingController();
    _basePriceWeekController = TextEditingController();
    if (widget.studio != null) {
      _selectedType = widget.studio!.type!;
      selectedLocation = LatLng(widget.studio!.location!.coordinates![1],
          widget.studio!.location!.coordinates![0]);
      _studioNameController.text = widget.studio!.name!;
      _aboutStudioController.text = widget.studio!.about!;
      _addressLine1Controller.text = widget.studio!.address!;
      _cityController.text = widget.studio!.city!;
      _stateController.text = widget.studio!.state!;
      _pincodeController.text = widget.studio!.pincode!;
      _areaSqFtController.text = widget.studio!.areaSqFt!;
      _selectedCategory = widget.studio!.category!;
      for (final price in widget.studio!.price!) {
        if (price.title == 'Monthly Rent') {
          _basePriceMonthController.text = price.amount.toString();
        }
        if (price.title == 'Daily Rent') {
          _basePriceDayController.text = price.amount.toString();
        }
        if (price.title == 'Weekly Rent') {
          _basePriceWeekController.text = price.amount.toString();
        }
        setState(() {
          isAnySelected = widget.studio!.facility!.contains('Any');
          isWifiSelected = widget.studio!.facility!.contains('WiFi');
          isSelfCheckInSelected =
              widget.studio!.facility!.contains('Self check-in');
          isTimeSelected = widget.studio!.facility!.contains('time');
          isFreeCancelSelected =
              widget.studio!.facility!.contains('Free cancel');
          isFreeParkingSelected =
              widget.studio!.facility!.contains('Free Parking');
          isSecuritySelected = widget.studio!.facility!.contains('Security');
          isMembersSelected = widget.studio!.facility!.contains('Members');
          isAirConditionerSelected =
              widget.studio!.facility!.contains('Air Conditioner');
          facilities = widget.studio!.facility;
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: widget.disableTextField!
                ? MediaQuery.of(context).size.height
                : widget.isEdit!
                    ? MediaQuery.of(context).size.height * 0.87
                    : MediaQuery.of(context).size.height * 0.72,
            child: SingleChildScrollView(
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
                  Center(
                    child: Text(
                      'Add Thumbnail',
                      style: GoogleFonts.inter(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    disableTextField: widget.disableTextField!,
                    controller: _studioNameController,
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
                      widget.disableTextField!
                          ? Text(
                              _selectedType,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                              ),
                            )
                          : DropdownButton<String>(
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
                  const SizedBox(height: 20),
                  CustomTextField(
                    disableTextField: widget.disableTextField!,
                    controller: _aboutStudioController,
                    height: 100,
                    hintText: 'About Studio',
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Address',
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      widget.disableTextField!
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () {
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
                                      selectedLocation = value;
                                    });
                                  }
                                });
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: AppColors.primaryBackgroundColor,
                                  ),
                                  Text(
                                    'Select From Maps',
                                    style: TextStyle(
                                        color:
                                            AppColors.primaryBackgroundColor),
                                  ),
                                ],
                              ),
                            ),
                    ],
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
                          icon: Icons.location_on_outlined,
                          hintText: 'City',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                          disableTextField: widget.disableTextField!,
                          controller: _stateController,
                          icon: Icons.location_on_outlined,
                          hintText: 'State',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    disableTextField: widget.disableTextField!,
                    controller: _pincodeController,
                    icon: Icons.location_on_outlined,
                    hintText: 'Pincode',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    disableTextField: widget.disableTextField!,
                    controller: _areaSqFtController,
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
                          widget.disableTextField!
                              ? null
                              : setState(() {
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
                          widget.disableTextField!
                              ? null
                              : setState(() {
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
                          widget.disableTextField!
                              ? null
                              : setState(() {
                                  isSelfCheckInSelected =
                                      !isSelfCheckInSelected;
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
                          widget.disableTextField!
                              ? null
                              : setState(() {
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
                          widget.disableTextField!
                              ? null
                              : setState(() {
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
                          widget.disableTextField!
                              ? null
                              : setState(() {
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
                          widget.disableTextField!
                              ? null
                              : setState(() {
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
                          widget.disableTextField!
                              ? null
                              : setState(() {
                                  isFreeParkingSelected =
                                      !isFreeParkingSelected;
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
                          widget.disableTextField!
                              ? null
                              : setState(() {
                                  isAirConditionerSelected =
                                      !isAirConditionerSelected;
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
                          imageUrls: widget.studio!.images,
                        )
                      : widget.disableTextField! || widget.isEdit!
                          ? MultipleImagesDisplay(
                              imageUrls: widget.studio!.images,
                            )
                          : _multipleFiles.isNotEmpty
                              ? MultipleImagesDisplay(
                                  imageFiles: _multipleFiles)
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
                                        color: const Color.fromRGBO(
                                            130, 130, 130, 1),
                                      ),
                                    ),
                                    child: const Image(
                                      image: AssetImage(
                                          "assets/images/add_image.png"),
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
                    disableTextField: widget.disableTextField!,
                    controller: _basePriceMonthController,
                    suffixLabel: '/Per month',
                    icon: Icons.price_change_outlined,
                    hintText: 'Base Price',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    disableTextField: widget.disableTextField!,
                    controller: _basePriceDayController,
                    suffixLabel: '/Per day',
                    icon: Icons.price_change_outlined,
                    hintText: 'Base Price',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    disableTextField: widget.disableTextField!,
                    controller: _basePriceWeekController,
                    suffixLabel: '/Per week',
                    icon: Icons.price_change_outlined,
                    hintText: 'Base Price',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: widget.disableTextField!
          ? null
          : AddStudioRequestButton(
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

                if (_basePriceDayController.text.isNotEmpty) {
                  _price ??= [];
                  _price!.add(Price(
                      title: 'Daily Rent',
                      amount: int.parse(_basePriceDayController.text),
                      discount: 0));
                }
                if (_basePriceMonthController.text.isNotEmpty) {
                  _price ??= [];
                  _price!.add(Price(
                      title: 'Monthly Rent',
                      amount: int.parse(_basePriceMonthController.text),
                      discount: 0));
                }
                if (_basePriceWeekController.text.isNotEmpty) {
                  _price ??= [];
                  _price!.add(Price(
                      title: 'Weekly Rent',
                      amount: int.parse(_basePriceWeekController.text),
                      discount: 0));
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
                  country: "india",
                  location: locationFromLatLng(selectedLocation),
                  category: _selectedCategory,
                  facility: facilities,
                  rentOrSell: 'Rent',
                  price: _price,
                );
                widget.studio != null
                    ? ref
                        .read(studioListControllerProvider.notifier)
                        .updateStudio(
                          studioId: widget.studio!.id!,
                          studio: updatedProfile,
                          context: context,
                          thumbnailFile: _thumbnailFile,
                          imageUrl: widget.studio!.images,
                          imageFiles: _multipleFiles,
                        )
                    : ref.read(studioControllerProvider.notifier).addNewStudio(
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
