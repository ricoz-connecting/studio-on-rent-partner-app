import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/commons/globals/register_dict.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class Register2 extends StatefulWidget {
  Register2(
      {
      super.key,
      this.cityValue,
      this.countryValue,
      this.stateValue,
      required this.businesscontroller,
      required this.address_1controller,
      required this.address_2controller,
      required this.pincodecontroller});
  final TextEditingController businesscontroller;

  final TextEditingController address_1controller;

  final TextEditingController address_2controller;
  String? countryValue;
  String? stateValue;
  String? cityValue;

  final TextEditingController pincodecontroller;

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  validateFunction() {
    _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextField(
                validator: (val) {
                  if (val!.isNotEmpty) {
                    registerDict.addAll({
                      'businessName': widget.businesscontroller.text.trim()
                    });
                  }
                  return null;
                },
                hintText: 'Enter business name (optional)',
                controller: widget.businesscontroller,
                icon: const Icon(Icons.business)),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 40),
              child: Text(
                'Enter your address',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            CustomTextField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Address Line 1 can\'t be empty';
                  }
                  return null;
                },
                hintText: 'Address Line 1',
                controller: widget.address_1controller,
                icon: const Icon(Icons.house)),
            CustomTextField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Address Line 2 can\'t be empty';
                  }
                  registerDict.addAll({
                    'address':
                        "${widget.address_1controller.text.trim()}, ${widget.address_2controller.text.trim()}"
                  } as Map<String, dynamic>);

                  return null;
                },
                hintText: 'Address Line 2',
                controller: widget.address_2controller,
                icon: const Icon(Icons.house)),
            // Row(
            //   children: [
            //     CustomTextField(
            //         right: 10,
            //         width: MediaQuery.of(context).size.width / 2,
            //         validator: (val) {
            //           if (val!.isEmpty) {
            //             return 'City 1 can\'t be empty';
            //           }
            //           registerDict.addAll(
            //               {"city": val!.trim()} as Map<String, dynamic>);
            //           return null;
            //         },
            //         hintText: 'City',
            //         controller: citycontroller,
            //         icon: Icon(Icons.house)),
            //     CustomTextField(
            //         left: 10,
            //         width: MediaQuery.of(context).size.width / 2.28,
            //         validator: (val) {
            //           if (val!.isEmpty) {
            //             return 'State can\'t be empty';
            //           }
            //           registerDict.addAll(
            //               {"state": val!.trim()} as Map<String, dynamic>);
            //           return null;
            //         },
            //         hintText: 'State',
            //         controller: statecontroller,
            //         icon: Icon(Icons.house))
            //   ],
            // ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 16),
              child: CSCPicker(
                ///Enable disable state dropdown [OPTIONAL PARAMETER]
                showStates: true,
                defaultCountry: CscCountry.India,
                disableCountry: true,

                /// Enable disable city drop down [OPTIONAL PARAMETER]
                showCities: true,

                ///Enable (get flat with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,

                ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                dropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 1)),

                ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                disabledDropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey.shade300, width: 1)),

                ///selected item style [OPTIONAL PARAMETER]
                selectedItemStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),

                ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                dropdownHeadingStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),

                ///DropdownDialog Item style [OPTIONAL PARAMETER]
                dropdownItemStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),

                ///Dialog box radius [OPTIONAL PARAMETER]
                dropdownDialogRadius: 10.0,

                ///Search bar radius [OPTIONAL PARAMETER]
                searchBarRadius: 10.0,

                ///triggers once country selected in dropdown
                onCountryChanged: (value) {
                  setState(() {
                    ///store value in country variable
                    widget.countryValue = value;
                  });
                },

                ///triggers once state selected in dropdown
                onStateChanged: (value) {
                  setState(() {
                    ///store value in state variable
                    widget.stateValue = value;
                    registerDict.addAll({"state": value});
                  });
                },

                ///triggers once city selected in dropdown
                onCityChanged: (value) {
                  setState(() {
                    ///store value in city variable
                    widget.cityValue = value;
                    registerDict.addAll({"city": value});
                  });
                },
              ),
            ),

            CustomTextField(
                textInputType: TextInputType.number,
                length: 6,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Pincode can\'t be empty';
                  }
                  registerDict
                      .addAll({"pincode": val.trim()} as Map<String, dynamic>);
                  return null;
                },
                hintText: 'Pincode',
                controller: widget.pincodecontroller,
                icon: const Icon(Icons.house)),
          ],
        ),
      ),
    );
  }
}
