// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/commons/params/studio_params.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/features/home/presentation/pages/home_view.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/category_entity.dart';
import 'package:studio_partner_app/src/features/stores/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:studio_partner_app/src/features/stores/presentation/bloc/map_bloc/map_bloc.dart';
import 'package:studio_partner_app/src/features/stores/presentation/bloc/request_bloc/request_bloc.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_error_box.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/register_4.dart';
import 'package:studio_partner_app/src/features/stores/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_field.dart';
import 'package:latlong2/latlong.dart';

class AddStorePage extends StatefulWidget {
  static const routePath = '/add-store-page';
  const AddStorePage({super.key});

  @override
  State<AddStorePage> createState() => _AddStorePageState();
}

class _AddStorePageState extends State<AddStorePage> {
  double? lat;
  double? lon;
  Uint8List? cover;
  Uint8List? front;
  Uint8List? gallary;
  int frontImages = 0;
  int gallaryImages = 0;
  List<Uint8List>? gallaryphotos;
  List<Uint8List>? frontPhotos;
  CategoryEntity? selectedCategories;

  List<Marker> markers = [
    Marker(
        point: const LatLng(28.644800, 77.216721),
        child: Icon(
          Icons.location_on,
          color: ColorAssets.primaryBlue,
        ))
  ];
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _pricecontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  final TextEditingController _tagscontroller = TextEditingController();
  final TextEditingController _aboutcontroller = TextEditingController();

  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lonController = TextEditingController();
  final TextEditingController _locController = TextEditingController();

  int sealectedCategoryIndex = 0;
  @override
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetCategory());
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: SimpleAppBar(
        bgColor: color.secondary,
        title: "Add Studio Request",
        centerTitle: false,
      ),
      body: BlocConsumer<RequestBloc, RequestState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is RequestSuccessState) {
            context.push(HomeView.routePath);
          }
        },
        builder: (context, state) {
          if (state is RequestLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
              child: BlocConsumer<CategoryBloc, CategoryState>(
                  listener: (context, state) {
            if (state is CategoryFailureState) {
              CustomErrorBox.showErrorBox(context, state.message, () {
                context.go(HomeView.routePath);
              });
            }
          }, builder: (context, state) {
            if (state is CategoryLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CategorySuccessState) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      validator: (validator) {
                        if (validator!.isEmpty) {
                          return 'Studio Name cannot be Empty';
                        }
                        return null;
                      },
                      hintText: 'Studio Name *',
                      controller: _namecontroller,
                    ),
                    CustomTextField(
                      validator: (validator) {
                        if (validator!.isEmpty) {
                          return 'Price cannot be Empty';
                        }
                        return null;
                      },
                      hintText: 'Price * ',
                      suffix: const Text('/ day'),
                      controller: _pricecontroller,
                      icon: const Icon(Icons.monetization_on),
                      textInputType: TextInputType.number,
                    ),
                    CustomTextField(
                      validator: (validator) {
                        if (validator!.isEmpty) {
                          return 'Address cannot be Empty';
                        }
                        return null;
                      },
                      hintText: 'Address *',
                      controller: _addresscontroller,
                      icon: const Icon(Icons.house),
                    ),
                    CustomTextField(
                      validator: (validator) {
                        if (validator!.isEmpty) {
                          return 'Tags cannot be Empty';
                        }
                        return null;
                      },
                      hintText:
                          'Tags* ex. Well Furnished, Well maintained, water supply',
                      controller: _tagscontroller,
                      icon: const Icon(Icons.house),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text("**Comma Separated Values Only"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 3,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Wrap(
                      children: [
                        BlocListener<LocationBloc, LocationState>(
                          listener: (context, state) {
                            if (state is LocationSuccessState) {
                              _latController.text =
                                  state.locationEntity.latitude.toString();
                              _lonController.text =
                                  state.locationEntity.longitude.toString();
                              _locController.text =
                                  state.locationEntity.location.toString();
                            }
                          },
                          child: CustomTextField(
                              right: 10,
                              width: MediaQuery.of(context).size.width / 2,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Latitude can\'t be empty';
                                }

                                return null;
                              },
                              hintText: 'Latitude*',
                              controller: _latController,
                              icon: const Icon(Icons.location_on)),
                        ),
                        CustomTextField(
                            left: 10,
                            width: MediaQuery.of(context).size.width / 2,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Longitude can\'t be empty';
                              }

                              return null;
                            },
                            hintText: 'Longitude*',
                            controller: _lonController,
                            icon: const Icon(Icons.location_on))
                      ],
                    ),
                    CustomTextField(
                      validator: (validator) {
                        if (validator!.isEmpty) {
                          return 'Location cannot be Empty';
                        }
                        return null;
                      },
                      hintText: 'Location*',
                      controller: _locController,
                      icon: const Icon(Icons.house),
                    ),
                    Wrap(
                      children: [
                        BlocBuilder<LocationBloc, LocationState>(
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                width: MediaQuery.of(context).size.width / 2,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                width: MediaQuery.of(context).size.width / 2,
                                child: CustomTextButton(
                                    text: 'Your Current Location',
                                    ontap: () {
                                      context
                                          .read<LocationBloc>()
                                          .add(GetLocationAuto());
                                    }));
                          },
                        ),
                        Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                            width: MediaQuery.of(context).size.width / 2,
                            child: CustomTextButton(
                                text: 'Select from Map',
                                ontap: () {
                                  // context.read<LocationBloc>().add(GetLocationAuto());
                                  showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                            child: SizedBox(
                                              height: 500,
                                              child: BlocBuilder<MapBloc,
                                                  MapState>(
                                                builder: (context, state) {
                                                  if (state is UpdateMapState) {
                                                    Stack(
                                                      children: [
                                                        FlutterMap(
                                                            options: MapOptions(
                                                              onTap: (tapPosition,
                                                                  point) async {
                                                                context
                                                                    .read<
                                                                        MapBloc>()
                                                                    .add(UpdateMap(
                                                                        latLng:
                                                                            point));
                                                                _latController
                                                                        .text =
                                                                    state.latLng
                                                                        .latitude
                                                                        .toString();
                                                                lat = state
                                                                    .latLng
                                                                    .latitude;
                                                                _lonController
                                                                        .text =
                                                                    state.latLng
                                                                        .latitude
                                                                        .toString();
                                                                lon = state
                                                                    .latLng
                                                                    .latitude;

                                                                Marker marker =
                                                                    Marker(
                                                                        point: state
                                                                            .latLng,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .location_on,
                                                                          color:
                                                                              color.error,
                                                                        ));
                                                                markers[0] =
                                                                    marker;

                                                                final placemarks = await GeocodingPlatform
                                                                    .instance!
                                                                    .placemarkFromCoordinates(
                                                                        point
                                                                            .latitude,
                                                                        point
                                                                            .longitude);
                                                                _locController.text = placemarks
                                                                        .first
                                                                        .locality ??
                                                                    placemarks
                                                                        .first
                                                                        .name ??
                                                                    placemarks
                                                                        .first
                                                                        .street ??
                                                                    placemarks
                                                                        .first
                                                                        .subLocality ??
                                                                    'UNABLE TO GET LOCATION';
                                                              },
                                                              initialCenter:
                                                                  state.latLng,
                                                            ),
                                                            children: [
                                                              TileLayer(
                                                                urlTemplate:
                                                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                                userAgentPackageName:
                                                                    'com.example.app',
                                                              ),
                                                              RichAttributionWidget(
                                                                attributions: [
                                                                  TextSourceAttribution(
                                                                    'OpenStreetMap contributors',
                                                                    onTap: () =>
                                                                        launchUrl(
                                                                            Uri.parse('https://openstreetmap.org/copyright')),
                                                                  ),
                                                                ],
                                                              ),
                                                              MarkerLayer(
                                                                  markers:
                                                                      markers)
                                                            ]),
                                                        const Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: CloseButton(),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                  return Stack(
                                                    children: [
                                                      FlutterMap(
                                                          options: MapOptions(
                                                            onTap: (tapPosition,
                                                                point) async {
                                                              context
                                                                  .read<
                                                                      MapBloc>()
                                                                  .add(UpdateMap(
                                                                      latLng:
                                                                          point));
                                                              _latController
                                                                      .text =
                                                                  point.latitude
                                                                      .toString();
                                                              lat = point
                                                                  .latitude;
                                                              _lonController
                                                                      .text =
                                                                  point
                                                                      .longitude
                                                                      .toString();
                                                              lon = point
                                                                  .longitude;

                                                              Marker marker =
                                                                  Marker(
                                                                      point:
                                                                          point,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .location_on,
                                                                        color: color
                                                                            .error,
                                                                      ));
                                                              markers[0] =
                                                                  marker;
                                                              final placemarks =
                                                                  await GeocodingPlatform
                                                                      .instance!
                                                                      .placemarkFromCoordinates(
                                                                          point
                                                                              .latitude,
                                                                          point
                                                                              .longitude);
                                                              _locController.text = placemarks
                                                                      .first
                                                                      .locality ??
                                                                  placemarks
                                                                      .first
                                                                      .name ??
                                                                  placemarks
                                                                      .first
                                                                      .street ??
                                                                  placemarks
                                                                      .first
                                                                      .subLocality ??
                                                                  'UNABLE TO GET LOCATION';
                                                            },
                                                            initialCenter: LatLng(
                                                                lat ??
                                                                    28.644800,
                                                                lon ??
                                                                    77.216721),
                                                            initialZoom: 5,
                                                          ),
                                                          children: [
                                                            TileLayer(
                                                              urlTemplate:
                                                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                              userAgentPackageName:
                                                                  'com.example.app',
                                                            ),
                                                            RichAttributionWidget(
                                                              attributions: [
                                                                TextSourceAttribution(
                                                                  'OpenStreetMap contributors',
                                                                  onTap: () =>
                                                                      launchUrl(
                                                                          Uri.parse(
                                                                              'https://openstreetmap.org/copyright')),
                                                                ),
                                                              ],
                                                            ),
                                                            MarkerLayer(
                                                                markers:
                                                                    markers)
                                                          ]),
                                                      const Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: CloseButton(),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ));
                                })),
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.only(
                            left: 20, bottom: 10, right: 20),
                        child: const Text(
                            '**You can Either Select your current Location or You can select from Map. We need your studio/property location to Show on our user map')),
                    const Divider(
                      thickness: 3,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, top: 20),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Category",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      padding: const EdgeInsets.only(bottom: 10),
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) => Container(
                                height: 29,
                                margin:
                                    EdgeInsets.only(left: index == 0 ? 20 : 15),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17, vertical: 6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: selectedCategories ==
                                              (state.categories[index])
                                          ? color.primary
                                          : color.onSecondary,
                                      width: selectedCategories ==
                                              (state.categories[index])
                                          ? 3
                                          : 1,
                                    )),
                                child: Center(
                                  child: Text(
                                    state.categories[index].title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: selectedCategories ==
                                              (state.categories[index])
                                          ? color.primary
                                          : color.onSecondary,
                                    ),
                                  ),
                                ),
                              ).onTap(() {
                                setState(() {
                                  selectedCategories = state.categories[index];
                                });
                              })),
                    ),
                    CustomTextField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'About cannot be Empty';
                        }
                        return null;
                      },
                      hintText: "About Section",
                      controller: _aboutcontroller,
                      minlines: 3,
                      maxlines: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, top: 20),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Images",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Wrap(
                      children: [
                        Container(
                          margin: cover != null
                              ? const EdgeInsets.fromLTRB(22, 22, 5, 22)
                              : null,
                          height: cover != null ? 100 : null,
                          width: cover != null ? 100 : null,
                          decoration: cover != null
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: MemoryImage(cover!),
                                      fit: BoxFit.cover))
                              : null,
                          child: cover != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                            blurStyle: BlurStyle.inner,
                                            blurRadius: 300)
                                      ]),
                                )
                              : CustomImagePick(
                                  color: color,
                                  type: "Media",
                                ),
                        ).onTap(() async {
                          final medias = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (medias != null) {
                            cover = await medias.readAsBytes();

                            setState(() {});
                          }
                        }),
                        Container(
                          margin: front != null
                              ? const EdgeInsets.fromLTRB(22, 22, 5, 22)
                              : null,
                          height: front != null ? 100 : null,
                          width: front != null ? 100 : null,
                          decoration: front != null
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: MemoryImage(front!),
                                      fit: BoxFit.cover))
                              : null,
                          child: front != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                            blurStyle: BlurStyle.inner,
                                            blurRadius: 300)
                                      ]),
                                  child: Center(
                                    child: Text(
                                      frontImages.toString(),
                                      style: TextStyle(
                                          fontSize: 30, color: color.secondary),
                                    ),
                                  ),
                                )
                              : CustomImagePick(
                                  color: color,
                                  type: "Media",
                                ),
                        ).onTap(() async {
                          final medias = await ImagePicker().pickMultiImage(
                              requestFullMetadata: false, limit: 2);
                          if (medias.isNotEmpty) {
                            final listofmediaBytes = await Future.wait(medias
                                .map((e) async => await e.readAsBytes())
                                .toList());
                            front = listofmediaBytes.first;
                            frontPhotos = listofmediaBytes;
                            frontImages = listofmediaBytes.length;
                            setState(() {});
                          }
                        }),
                        Container(
                          margin: gallary != null
                              ? const EdgeInsets.fromLTRB(22, 22, 5, 22)
                              : null,
                          height: gallary != null ? 100 : null,
                          width: gallary != null ? 100 : null,
                          decoration: gallary != null
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: MemoryImage(gallary!),
                                      fit: BoxFit.cover))
                              : null,
                          child: gallary != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                            blurStyle: BlurStyle.inner,
                                            blurRadius: 300)
                                      ]),
                                  child: Center(
                                    child: Text(
                                      gallaryImages.toString(),
                                      style: TextStyle(
                                          fontSize: 30, color: color.secondary),
                                    ),
                                  ),
                                )
                              : CustomImagePick(
                                  color: color,
                                  type: "Media",
                                ),
                        ).onTap(() async {
                          final medias = await ImagePicker().pickMultiImage(
                              requestFullMetadata: false, limit: 30);
                          if (medias.isNotEmpty) {
                            final listofmediaBytes = await Future.wait(medias
                                .map((e) async => await e.readAsBytes())
                                .toList());
                            gallary = listofmediaBytes.first;
                            gallaryphotos = listofmediaBytes;
                            gallaryImages = listofmediaBytes.length;
                            setState(() {});
                          }
                        }),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 7),
                      child: CustomTextButton(
                          borderRadius: 10,
                          text: "Post Add Studio Request",
                          ontap: () {
                            if (selectedCategories == null) {
                              CustomErrorBox.showErrorBox(
                                  context, 'Select a Category for FrontImage',
                                  () {
                                context.pop();
                                return;
                              });
                            } else if (frontImages < 2) {
                              CustomErrorBox.showErrorBox(
                                  context, 'Atleast 2 Images for FrontImage',
                                  () {
                                context.pop();
                                return;
                              });
                            } else if (gallaryImages < 5) {
                              CustomErrorBox.showErrorBox(
                                  context, 'Atleast 5 Images for FrontImage',
                                  () {
                                context.pop();
                                return;
                              });
                            }
                            if (_formKey.currentState!.validate()) {
                              final params = StudioParams(
                                  address: _addresscontroller.text.trim(),
                                  name: _namecontroller.text.trim(),
                                  rent: double.parse(_pricecontroller.text),
                                  location: _locController.text.trim(),
                                  tags: _tagscontroller.text.trim().split(','),
                                  latitude:
                                      double.parse(_latController.text.trim()),
                                  longitude:
                                      double.parse(_latController.text.trim()),
                                  category: selectedCategories!.title,
                                  description: _aboutcontroller.text.trim(),
                                  agents: [globalAgentId],
                                  gallary: gallaryphotos ?? [],
                                  frontImage: frontPhotos ?? [],
                                  cover: cover ?? Uint8List.fromList([]));
                              context.read<RequestBloc>().add(
                                  StudioAddRequestEvent(studioParams: params));
                            }
                          }),
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          }));
        },
      ),
    );
  }
}
