import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/auth/presentation/pages/otp/login_otp.dart';
import 'package:studio_partner_app/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:studio_partner_app/src/features/help/presentation/pages/help_page.dart';
import 'package:studio_partner_app/src/features/profile/prsesntation/widgets/bank_details.dart';
import 'package:studio_partner_app/src/features/profile/prsesntation/widgets/edit_profile_info.dart';

class ProfilePage extends StatefulWidget {
  static const routePath = '/profile-page';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.surface,
      appBar: SimpleAppBar(
        bgColor: color.secondary,
        title: "Profile",
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 100,
                width: 100,
                margin: const EdgeInsets.all(20),
                child: Stack(
                  children: [
                    SizedBox(
                        child: CircleAvatar(
                      radius: 50,
                      backgroundImage: MemoryImage(globalAgentModel!.photoUrl),
                      backgroundColor: color.tertiary,
                    )),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.verified,
                        color: color.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InfoBoxes(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Hi,${globalAgentModel!.name}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.call,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        globalAgentModel!.phoneNumber,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InfoBoxes(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Business/Restaurant Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 10),
                      ),
                      Text(
                        globalAgentModel!.businessname ?? 'Not Provided',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 13),
                      ),
                      const Text(
                        "Address",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 10),
                      ),
                      Text(
                        globalAgentModel!.address,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 13),
                      ),
                      const Text(
                        "Services",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 10),
                      ),
                      for (var i in globalAgentModel!.service)
                        Text(
                          i,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 13),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Wrap(
              children: [
                GestureDetector(
                  onTap: () {
                    context.push(HelpPage.routePath);
                  },
                  child: const InfoBoxes(
                    width: 170,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.help),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Help")
                        ]),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.push(EditProfileInfoView.routePath);
                  },
                  child: const InfoBoxes(
                    width: 170,
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Edit")
                      ],
                    ),
                  ),
                ),
                const InfoBoxes(
                  width: 170,
                  child: Row(
                    children: [
                      Icon(Icons.history),
                      SizedBox(
                        width: 10,
                      ),
                      Text("History")
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.push(BankDetails.routePath);
                  },
                  child: const InfoBoxes(
                    width: 170,
                    child: Row(
                      children: [
                        Icon(Icons.house),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Bank Details")
                      ],
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Hive.box("USER").clear();
                context.go(LoginOtp.routePath);
              },
              child: InfoBoxes(
                child: Row(
                  children: [
                    const Expanded(child: Icon(Icons.logout)),
                    Expanded(
                      flex: 6,
                      child: Text(
                        "LogOut",
                        style: TextStyle(color: color.error),
                      ),
                    ),
                    const Expanded(child: Icon(Icons.arrow_right))
                  ],
                ),
              ),
            ),
            InfoBoxes(
              child: Row(
                children: [
                  const Expanded(child: Icon(Icons.logout)),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "Delete Account",
                      style: TextStyle(color: color.error),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InfoBoxes extends StatefulWidget {
  final Widget? child;
  final double? width;
  final double padding;
  final double margin;
  const InfoBoxes(
      {super.key, this.child, this.width, this.padding = 20, this.margin = 20});

  @override
  State<InfoBoxes> createState() => _InfoBoxesState();
}

class _InfoBoxesState extends State<InfoBoxes> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Container(
      constraints: BoxConstraints(maxWidth: widget.width ?? double.infinity),
      padding: EdgeInsets.all(widget.padding),
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: color.surface, blurRadius: 3, spreadRadius: 3)
      ], color: color.secondary, borderRadius: BorderRadius.circular(15)),
      child: widget.child,
    );
  }
}
