import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:studio_partner_app/src/features/home/presentation/pages/home_view.dart';
import 'package:studio_partner_app/src/res/assets.dart';

class VerificationRequestPage extends StatefulWidget {
  static const routePath = '/verification-page';
  const VerificationRequestPage({super.key});

  @override
  State<VerificationRequestPage> createState() =>
      _VerificationRequestPageState();
}

class _VerificationRequestPageState extends State<VerificationRequestPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (globalAgentId != '') {
      context.read<AuthBloc>().add(Verification(agentId: globalAgentId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Verification",
        centerTitle: false,
        leadingCallback: () {
          context.push(HomeView.routePath);
        },
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is VerificationSuccess && state.status == 'verified') {
            context.go(HomeView.routePath);
          }
          if (state is AuthFailure) {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                      child: SizedBox(
                        height: 300,
                        child: Text(state.message),
                      ),
                    ));
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is VerificationSuccess) {
            return const SizedBox();
          } else {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImageAssets.verficationWaiting)),
                    ),
                    child: Icon(
                      Icons.hourglass_top_sharp,
                      size: 100,
                      color: ColorAssets.white,
                    ),
                  ),
                  const Text(
                    "Your details are sent for",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  const Text(
                    " verification",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  const Text("you’ll be notified once verification is complete")
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
