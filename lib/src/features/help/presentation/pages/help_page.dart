import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/help/domain/entity/help_entity.dart';
import 'package:studio_partner_app/src/features/help/presentation/bloc/help_bloc/help_bloc.dart';
import 'package:studio_partner_app/src/features/help/presentation/pages/raise_ticket_page.dart';
import 'package:studio_partner_app/src/features/profile/prsesntation/views/profile_page.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';

class HelpPage extends StatefulWidget {
  static const routePath = '/help-page';
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HelpBloc>().add(GetHelpEvent());
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.surface,
      appBar: SimpleAppBar(
        bgColor: color.secondary,
        title: "Help",
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InfoBoxes(
              child: BlocBuilder<HelpBloc, HelpState>(
                builder: (context, state) {
                  if (state is HelpSuccessState) {
                    return Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Help & FAQs")),
                        SizedBox(
                          height: 20,
                        ),
                        for (var i in state.helps)
                          HelpExpansionTIle(color: color, helpEntity: i),
                        ExpansionTile(
                          backgroundColor: color.secondary,
                          title: Text("Contact us"),
                          shape: Border.all(color: color.secondary),
                          children: [
                            Wrap(
                              children: [
                                ContactOption(
                                  color: color,
                                  text: "Mail Us",
                                  icon: Icon(Icons.mail_outline_outlined),
                                ),
                                ContactOption(
                                  color: color,
                                  text: "Call Us",
                                  icon: Icon(Icons.call),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(8),
        height: 50,
        alignment: Alignment.bottomCenter,
        child: CustomTextButton(
          ontap: () {
            context.push(RaiseTicketPage.routePath);
          },
          text: "Raise a Ticket",
        ),
      ),
    );
  }
}

class HelpExpansionTIle extends StatelessWidget {
  const HelpExpansionTIle({
    super.key,
    required this.color,
    required this.helpEntity,
  });
  final HelpEntity helpEntity;
  final ColorScheme color;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: color.secondary,
      title: Text(helpEntity.title),
      shape: Border.all(color: color.secondary),
      children: [Text(helpEntity.description)],
    );
  }
}

class ContactOption extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback? onTap;
  const ContactOption({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
    this.onTap,
  });

  final ColorScheme color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: color.onSurface),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(
              width: 10,
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}

class Helps extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const Helps({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          margin: EdgeInsets.all(5),
          child: ExpansionTile(
            title: Text(text),
          )),
    );
  }
}
