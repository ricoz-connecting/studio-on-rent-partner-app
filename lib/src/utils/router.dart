import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:studio_partner_app/src/commons/views/location_access/location_access_page.dart';
import 'package:studio_partner_app/src/commons/views/splash_view/splash_view.dart';
import 'package:studio_partner_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:studio_partner_app/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:studio_partner_app/src/features/chat/presentation/pages/chat_page.dart';
import 'package:studio_partner_app/src/features/help/presentation/pages/help_page.dart';
import 'package:studio_partner_app/src/features/help/presentation/pages/raise_ticket_page.dart';
import 'package:studio_partner_app/src/features/home/presentation/tabs/earning_page.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/tabs/review_page.dart';
import 'package:studio_partner_app/src/features/home/presentation/pages/home_view.dart';
import 'package:studio_partner_app/src/features/profile/widgets/add_bank_details.dart';
import 'package:studio_partner_app/src/features/profile/widgets/bank_details.dart';
import 'package:studio_partner_app/src/features/profile/widgets/edit_profile_info.dart';
import 'package:studio_partner_app/src/features/profile/widgets/complete_profile_info.dart';
import 'package:studio_partner_app/src/features/profile/views/profile_page.dart';
import 'package:studio_partner_app/src/features/register/presentation/pages/register.dart';
import 'package:studio_partner_app/src/features/home/presentation/tabs/stores_page.dart';
import 'package:studio_partner_app/src/features/stores/presentation/pages/add_store_page.dart';

final GoRouter router = GoRouter(
  initialLocation: _cachedUser(),
  routes: [
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
    final token = box.get('token');
    if (token != null) {
      final bool val = Jwt.isExpired(token);

      if (val) {
        return SplashView.routePath;
      } else {
        final userDetails = Jwt.parseJwt(token);
        // user = User.fromMap(userDetails);
        // return HomeView.routePath;
      }
    } else {
      return SplashView.routePath;
    }
  } else {
    return SplashView.routePath;
  }
}
