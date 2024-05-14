import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studio_partner_app/src/commons/globals/register_dict.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/register_4.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_check_box.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';

class Register3 extends StatefulWidget {
  Register3({super.key, required this.services});
  List<String> services;

  @override
  State<Register3> createState() => _Register3State();
}

class _Register3State extends State<Register3> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    List<String> availableServices = [
      "Photography",
      "Dance",
      "Occasion",
      "On Demand"
    ];
    List<String> addOns = ["Trainers", "A.C.", "Cleaners", "Wifi"];
    List<String> service = [
      "Cleaning Services",
      "Photography Services",
      "Training Services",
      "Wifi"
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Select services you offer'),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: color.onSecondary),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Available Studio Service’s',
                        style: const TextStyle()
                            .copyWith(fontWeight: FontWeight.w500)),
                  ),
                  Wrap(
                    children: availableServices
                        .map((e) => CustomCheckBox(
                            value: widget.services.contains(e),
                            handleCheckBox: () {
                              if (widget.services.contains(e)) {
                                widget.services.remove(e);
                                return;
                              }
                              widget.services.add(e);
                            },
                            data: e))
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add Ons',
                      style: const TextStyle()
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Wrap(
                    children: addOns
                        .map((e) => CustomCheckBox(
                            value: widget.services.contains(e),
                            handleCheckBox: () {
                              if (widget.services.contains(e)) {
                                widget.services.remove(e);
                                return;
                              }
                              registerDict
                                  .addAll({"services": widget.services});

                              widget.services.add(e);
                            },
                            data: e))
                        .toList(),
                  ),
                ],
              ),
            ),
            for (var i in service)
              CustomCheckBox(
                value: widget.services.contains(i),
                handleCheckBox: () {
                  if (widget.services.contains(i)) {
                    widget.services.remove(i);
                    return;
                  }
                  widget.services.add(i);
                  registerDict.addAll({"services": widget.services});
                  log(widget.services.toString());
                },
                data: i,
                minimumsize: MainAxisSize.max,
              ),
            TextFormField(
              enabled: false,
              decoration: const InputDecoration(border: InputBorder.none),
              validator: (val) {
                if (widget.services.length < 3) {
                  pleasePickAtleast3(context, color);
                  return '';
                }
                registerDict.addAll(
                    {"services": widget.services} as Map<String, dynamic>);
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> pleasePickAtleast3(BuildContext context, ColorScheme color) {
    return showAdaptiveDialog(
      context: context,
      builder: (contexta) => Dialog(
        child: Container(
          decoration: BoxDecoration(
              color: color.secondary, borderRadius: BorderRadius.circular(15)),
          height: 300,
          width: 300,
          constraints: const BoxConstraints(maxHeight: 300, maxWidth: 300),
          child: const Center(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: CloseButton(),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text("Please Select at least 3"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
