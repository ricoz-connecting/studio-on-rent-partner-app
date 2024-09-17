import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/commons/views/splashscreen.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/add_studio_request.dart';
import 'package:studio_partner_app/src/feature/auth/views/forgot_password.dart';
import 'package:studio_partner_app/src/feature/auth/views/login_screen.dart';
import 'package:studio_partner_app/src/feature/auth/views/recover_pass_email.dart';
import 'package:studio_partner_app/src/feature/auth/views/reset_pass_sms.dart';
import 'package:studio_partner_app/src/feature/auth/views/verify_otp.dart';
import 'package:studio_partner_app/src/feature/navigation/navigation_page.dart';
import 'package:studio_partner_app/src/feature/profile/views/complete_profile.dart';
import 'package:studio_partner_app/src/feature/profile/views/profile_screen.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/bank_details.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/edit_profile.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/help.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/history_screen.dart';
import '../src/feature/auth/views/landing_screen.dart';
import '../src/feature/auth/views/signup.dart';
import '../src/feature/profile/models/profile.dart';

class StudioRoutes {
  static const String splashScreen = '/';
  static const String loginViaEmailScreen = '/loginEmail';
  static const String loginViaPhone = '/loginPhone';
  static const String otpScreen = '/otp';
  static const String signUpViaEmailScreen = '/signUpEmail';
  static const String forgotPasswordScreen = '/forgotPassword';
  static const String resetViaEmailScreen = '/resetEmail';
  static const String resetViaPhone = '/resetPhone';
  static const String verifyOtpScreen = '/verifyOtp';
  static const String setNewPasswordScreen = '/setNewPassword';
  static const String createProfileScreen = '/createProfile';
  static const String bottomNavBar = '/navBar';
  static const String bookings = '/bookings';
  static const String chat = '/chat';
  static const String studio = '/studio';
  static const String earnings = '/earnings';
  static const String profileScreen = '/profile';
  static const String settingsScreen = '/settings';
  static const String landingScreen = '/landing';
  static const String addStudioRequest = '/studio/add';
  static const String helpScreen = '/help';
  static const String editProfile = '/editProfile';
  static const String historyScreen = '/history';
  static const String bankDetails = '/bankDetails';
}

class StudioRouter {
  static final GoRouter router = GoRouter(
    initialLocation: StudioRoutes.splashScreen,
    routes: <RouteBase>[
      GoRoute(
          path: StudioRoutes.splashScreen,
          builder: (context, state) => const Splashscreen()),
      GoRoute(
        path: StudioRoutes.loginViaEmailScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: StudioRoutes.signUpViaEmailScreen,
        builder: (BuildContext context, GoRouterState state) => const Signup(),
      ),
      GoRoute(
        path: StudioRoutes.bottomNavBar,
        builder: (BuildContext context, GoRouterState state) =>
            const BottomNavBar(),
      ),
      GoRoute(
          path: StudioRoutes.landingScreen,
          builder: (BuildContext context, GoRouterState state) =>
              const LandingScreen()),
      GoRoute(
          path: StudioRoutes.profileScreen,
          builder: (BuildContext context, GoRouterState state) {
            final profile = state.extra as Profile;
            return ProfileScreen(profile: profile);
          }),
      GoRoute(
          path: StudioRoutes.addStudioRequest,
          builder: (BuildContext context, GoRouterState state) =>
              const AddStudioRequest()),
      GoRoute(
          path: StudioRoutes.helpScreen,
          builder: (context, state) => const HelpPage()),
      GoRoute(
          path: StudioRoutes.editProfile,
          builder: (context, state) => const EditProfile()),
      GoRoute(
          path: StudioRoutes.historyScreen,
          builder: (context, state) => const HistoryPage()),
      GoRoute(
          path: StudioRoutes.bankDetails,
          builder: (context, state) => const BankDetails()),
      GoRoute(
          path: StudioRoutes.createProfileScreen,
          builder: (context, state) => const CompleteProfileScreen()),
      GoRoute(
          path: StudioRoutes.forgotPasswordScreen,
          builder: (context, state) => const ForgotPassword()),
      GoRoute(
          path: StudioRoutes.resetViaEmailScreen,
          builder: (context, state) => const RecoverPassEmail()),
      GoRoute(
          path: StudioRoutes.resetViaPhone,
          builder: (context, state) => const ResetPassSms()),
          GoRoute(path: StudioRoutes.verifyOtpScreen, builder: (context, state) => const VerifyOtp()),
    ],
  );
}
