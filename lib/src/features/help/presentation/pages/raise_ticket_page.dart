import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_field.dart';

class RaiseTicketPage extends StatefulWidget {
  static const routePath = "/raise-ticket-page";
  const RaiseTicketPage({super.key});

  @override
  State<RaiseTicketPage> createState() => _RaiseTicketPageState();
}

class _RaiseTicketPageState extends State<RaiseTicketPage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.secondary,
      appBar: SimpleAppBar(
        bgColor: color.secondary,
        title: "Complaint",
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  child: Image.asset(ImageAssets.raiseTicket),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      text: "Subject",
                      style: TextStyle().copyWith(
                          color: color.onSurface,
                          fontWeight: FontWeight.w500,
                          fontSize: 21),
                      children: [
                        TextSpan(
                            text: "*",
                            style: TextStyle().copyWith(color: color.error))
                      ]),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: color.onSecondary),
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.all(5),
                  title: Text("Select subject"),
                  shape: Border.all(color: color.secondary),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description",
                  style: TextStyle().copyWith(
                      color: color.onSurface,
                      fontWeight: FontWeight.w500,
                      fontSize: 21),
                ),
              ),
              CustomTextField(
                left: 0,
                right: 0,
                validator: (val) {
                  return null;
                },
                borderRadius: 7,
                hintText: "Add a Description",
                controller: TextEditingController(),
              ),
              Text(
                  "Please enter the details of your request. A member of support staff will respond as soon as possible."),
              SizedBox(
                height: 30,
              ),
              CustomTextButton(
                text: "Submit Request",
                ontap: () {},
                borderRadius: 10,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: color.secondary,
                    border: Border.all(color: color.tertiary)),
                child: Column(
                  children: [
                    TableData(
                      color: color,
                      isData: false,
                    ),
                    TableData(
                      color: color,
                    ),
                    TableData(color: color),
                    TableData(color: color),
                    TableData(color: color),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TableData extends StatelessWidget {
  final bool isData;
  const TableData({
    super.key,
    required this.color,
    this.isData = true,
  });

  final ColorScheme color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isData ? color.secondary : color.surface,
          border: Border.all(color: color.tertiary)),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("#"),
          Text("Subject"),
          Text("Requested"),
          Text("Status"),
        ],
      ),
    );
  }
}
