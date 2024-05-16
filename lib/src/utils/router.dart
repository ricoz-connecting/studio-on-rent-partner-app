import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/commons/views/location_access/location_access_page.dart';
import 'package:studio_partner_app/src/commons/views/splash_view/splash_view.dart';
import 'package:studio_partner_app/src/features/auth/data/datasource/remote_data_source.dart';
import 'package:studio_partner_app/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:studio_partner_app/src/features/auth/domain/usecase/get_otp.dart';
import 'package:studio_partner_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:studio_partner_app/src/features/auth/presentation/pages/otp/login_otp.dart';
import 'package:studio_partner_app/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:studio_partner_app/src/features/chat/presentation/pages/chat_page.dart';
import 'package:studio_partner_app/src/features/help/presentation/pages/help_page.dart';
import 'package:studio_partner_app/src/features/help/presentation/pages/raise_ticket_page.dart';
import 'package:studio_partner_app/src/features/home/presentation/tabs/earning_page.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/tabs/review_page.dart';
import 'package:studio_partner_app/src/features/home/presentation/pages/home_view.dart';
import 'package:studio_partner_app/src/features/home/presentation/widgets/booking_details.dart';
import 'package:studio_partner_app/src/features/profile/widgets/add_bank_details.dart';
import 'package:studio_partner_app/src/features/profile/widgets/bank_details.dart';
import 'package:studio_partner_app/src/features/profile/widgets/edit_profile_info.dart';
import 'package:studio_partner_app/src/features/profile/widgets/complete_profile_info.dart';
import 'package:studio_partner_app/src/features/profile/views/profile_page.dart';
import 'package:studio_partner_app/src/features/register/presentation/pages/register.dart';
import 'package:studio_partner_app/src/features/home/presentation/tabs/stores_page.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/verification_pending_page.dart';
import 'package:studio_partner_app/src/features/stores/presentation/pages/add_store_page.dart';
import 'package:studio_partner_app/src/features/stores/presentation/pages/studio_page.dart';

final GoRouter router = GoRouter(
  initialLocation: _cachedUser(),
  routes: [
    GoRoute(
        path: BookingView.routePath,
        builder: (context, state) {
         final extra = state.extra as Map;
          return  BookingView(
            id: extra['id']??'2345422',
          );
        }),
    GoRoute(
      path: VerificationRequestPage.routePath,
      builder: (context, state) => const VerificationRequestPage(),
    ),
    GoRoute(
      path: LoginOtp.routePath,
      builder: (context, state) => const LoginOtp(),
    ),
    GoRoute(
      path: BookingDetails.routePath,
      builder: (context, state) => const BookingDetails(),
    ),
    GoRoute(
      path: RaiseTicketPage.routePath,
      builder: (context, state) => const RaiseTicketPage(),
    ),
    GoRoute(
      path: HelpPage.routePath,
      builder: (context, state) => const HelpPage(),
    ),
    GoRoute(
      path: AddBankDetails.routrPath,
      builder: (context, state) => const AddBankDetails(),
    ),
    GoRoute(
      path: BankDetails.routePath,
      builder: (context, state) => const BankDetails(),
    ),
    GoRoute(
      path: EditProfileInfoView.routePath,
      builder: (context, state) => const EditProfileInfoView(),
    ),
    GoRoute(
      path: ProfilePage.routePath,
      builder: (context, state) {
        return const ProfilePage();
      },
    ),
    GoRoute(
        path: AddStorePage.routePath,
        builder: (context, state) {
          return AddStorePage();
        }),
    GoRoute(
        path: EarningPage.routePath,
        builder: (context, state) {
          return EarningPage();
        }),
    GoRoute(
        path: ChatPage.routePath,
        builder: (context, state) {
          return ChatPage();
        }),
    GoRoute(
      path: HomeView.routePath,
      builder: (context, state) {
        return HomeView();
      },
    ),
    GoRoute(
      path: Register.routePath,
      builder: (context, state) {
        return const Register();
      },
    ),
    GoRoute(
      path: SplashView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
    ),
    GoRoute(
      path: LoginPage.routePath,
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: SignUpPage.routePath,
      builder: (context, state) {
        return const SignUpPage();
      },
    ),
    GoRoute(
      path: CompleteYourProfileInfoView.routePath,
      builder: (context, state) {
        return const CompleteYourProfileInfoView();
      },
    ),
    GoRoute(
      path: LocationAccessPage.routePath,
      builder: (context, state) {
        return const LocationAccessPage();
      },
    ),
  ],
);

_cachedUser() {
  final box = Hive.box('USER');
  if (box.isNotEmpty) {
    final agentId = box.get('agentId');
    log(agentId.toString());
    if (agentId != null) {
      globalAgentId = agentId;
      return VerificationRequestPage.routePath;
    } else {
      return SplashView.routePath;
    }
  } else {
    return SplashView.routePath;
  }
}
