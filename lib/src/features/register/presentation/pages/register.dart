import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:studio_partner_app/src/commons/globals/register_dict.dart';
import 'package:studio_partner_app/src/commons/params/register_params.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/home/presentation/pages/home_view.dart';
import 'package:studio_partner_app/src/features/register/presentation/bloc/register_bloc.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/register_1.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/register_2.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/register_3.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/register_4.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/register_5.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/verification_pending_page.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';

class Register extends StatefulWidget {
  static const routePath = '/register-page';
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  final TextEditingController nameEditingController = TextEditingController();

  final TextEditingController emailEditingController = TextEditingController();
  TextEditingController businesscontroller = TextEditingController();

  TextEditingController address_1controller = TextEditingController();

  TextEditingController address_2controller = TextEditingController();

  TextEditingController citycontroller = TextEditingController();

  TextEditingController statecontroller = TextEditingController();

  TextEditingController pincodecontroller = TextEditingController();

  TextEditingController documentEditingController = TextEditingController();

  TextEditingController aboutEditingController = TextEditingController();

  TextEditingController qrDataEditingController = TextEditingController();
  Uint8List? firstImage;
  Uint8List? front;
  Uint8List? backs;
  Uint8List? image;
  String? city;
  String? state;
  String? country;
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> services = [];
  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const SimpleAppBar(
        title: 'Register',
        centerTitle: false,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        height: 75,
        child: CustomTextButton(
          ontap: () async {
            // log(_pageController.page.toString());
            if (_pageController.page != 4) {
              if (_formKey.currentState!.validate()) {
                await _pageController.nextPage(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.linear);
              }
            } else {
              if (_formKey.currentState!.validate()) {
                // log(registerDict.toString());
                final params = RegisterParams.fromMap(
                    Map<String, dynamic>.from(registerDict));
                context.read<RegisterBloc>().add(RegisterAgent(params: params));

                context.push(VerificationRequestPage.routePath);
              }
            }
          },
          bgColor: color.primary,
          text: 'Continue',
          textColor: color.onPrimary,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            PageView(
              scrollBehavior: const ScrollBehavior().copyWith(scrollbars: true),
              controller: _pageController,
              children: [
                Register1(
                  nameEditingController: nameEditingController,
                  emailEditingController: emailEditingController,
                  image: image,
                ),
                Register2(
                  cityValue: city,
                  stateValue: state,
                  countryValue: country,
                  pincodecontroller: pincodecontroller,
                  businesscontroller: businesscontroller,
                  address_1controller: address_1controller,
                  address_2controller: address_2controller,
                ),
                Register3(
                  services: services,
                ),
                Register4(
                  front: front,
                  backs: backs,
                  textEditingController: documentEditingController,
                ),
                Register5(
                  firstImage: firstImage,
                  qrDataEditingController: qrDataEditingController,
                  aboutEditingController: aboutEditingController,
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 5,
                effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: color.onSecondaryContainer),
              ),
            )
          ],
        ),
      ),
    );
  }
}
