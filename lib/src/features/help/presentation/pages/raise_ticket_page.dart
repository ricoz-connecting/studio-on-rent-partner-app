import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_drop_down_widget/flutter_custom_drop_down_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/help/data/model/table_model.dart';
import 'package:studio_partner_app/src/features/help/domain/entity/table_entity.dart';
// import 'package:studio_partner_app/src/features/help/presentation/bloc/issues_bloc.dart';
import 'package:studio_partner_app/src/features/help/presentation/bloc/issues_bloc/issues_bloc.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_error_box.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_field.dart';
import 'package:uuid/uuid.dart';

class RaiseTicketPage extends StatefulWidget {
  static const routePath = "/raise-ticket-page";
  const RaiseTicketPage({super.key});

  @override
  State<RaiseTicketPage> createState() => _RaiseTicketPageState();
}

class _RaiseTicketPageState extends State<RaiseTicketPage> {
  @override
  @override
  void initState() {
    super.initState();
    context.read<IssuesBloc>().add(GetIssuesEvent(agentId: globalAgentId));
  }

  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    List<String> subjects = [
      "Payment",
      "Studio/Store",
      "Verification",
      "Others"
    ];
    String? selectedSubject;
    final TextEditingController descriptionController = TextEditingController();
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
                  child: Container(
                    child: DropdownButtonFormField(
                        hint: Text("Select Subject"),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20)),
                        onChanged: (value) {
                          if (value != null) {
                            selectedSubject = value;
                          }
                        },
                        items: subjects
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList()),
                  )),
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
                controller: descriptionController,
              ),
              Text(
                  "Please enter the details of your request. A member of support staff will respond as soon as possible."),
              SizedBox(
                height: 30,
              ),
              CustomTextButton(
                text: "Submit Request",
                ontap: () {
                  if (descriptionController.text.isEmpty ||
                      selectedSubject == null) {
                    showErrorBox(context,
                        "Please Select a subject and write a detail description about your issues",
                        () {
                      context.pop();
                    });
                  } else
                    context.read<IssuesBloc>().add(SendIssuesEvent(
                        tableEntity: TableModel(
                            createdAt: DateTime.now(),
                            id: Uuid().v4(),
                            status: "pending",
                            subject: selectedSubject!)));
                },
                borderRadius: 10,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: color.secondary,
                    border: Border.all(color: color.tertiary)),
                child: BlocBuilder<IssuesBloc, IssuesState>(
                  builder: (context, state) {
                    if (state is IssuesSuccessState) {
                      return Column(
                        children: [
                          TableData(
                            color: color,
                            isData: false,
                          ),
                          for (var i in state.tables)
                            TableData(
                              color: color,
                              tableEntity: i,
                            )
                        ],
                      );
                    } else {
                      return TableData(
                        color: color,
                        isData: false,
                      );
                    }
                  },
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
  final TableEntity? tableEntity;
  const TableData({
    this.tableEntity,
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
        children: tableEntity == null
            ? [
                Text("#"),
                Text("Subject"),
                Text("Requested"),
                Text("Status"),
              ]
            : [
                Text(tableEntity!.id.slice(-4)),
                Text(tableEntity!.subject),
                Text(Intl()
                    .date(DateFormat.ABBR_MONTH_WEEKDAY_DAY)
                    .format(tableEntity!.createdAt)),
                Text(tableEntity!.status),
              ],
      ),
    );
  }
}
