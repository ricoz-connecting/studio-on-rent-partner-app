import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/commons/views/splashscreen.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/add_studio_request.dart';
import 'package:studio_partner_app/src/feature/auth/views/forgot_password.dart';
import 'package:studio_partner_app/src/feature/auth/views/login_screen.dart';
import 'package:studio_partner_app/src/feature/auth/views/recover_pass_email.dart';
import 'package:studio_partner_app/src/feature/auth/views/reset_pass_sms.dart';
import 'package:studio_partner_app/src/feature/auth/views/send_otp.dart';
import 'package:studio_partner_app/src/feature/auth/views/setnewpass.dart';
import 'package:studio_partner_app/src/feature/auth/views/signin_with_phone.dart';
import 'package:studio_partner_app/src/feature/complains/views/complaint_description.dart';
import 'package:studio_partner_app/src/feature/complains/views/previous_complaint.dart';
import 'package:studio_partner_app/src/feature/customer_reviews.dart/views/customer_review.dart';
import 'package:studio_partner_app/src/feature/customer_reviews.dart/views/studio_review.dart';
import 'package:studio_partner_app/src/feature/kyc_verification/views/kyc_page.dart';
import 'package:studio_partner_app/src/feature/kyc_verification/views/verification.dart';
import 'package:studio_partner_app/src/feature/auth/views/verify_otp.dart';
import 'package:studio_partner_app/src/feature/landing/views/onboarding_screen.dart';
import 'package:studio_partner_app/src/feature/membership_payment/view/membership_payment_page.dart';
import 'package:studio_partner_app/src/feature/navigation/navigation_page.dart';
import 'package:studio_partner_app/src/feature/profile/views/complete_profile.dart';
import 'package:studio_partner_app/src/feature/profile/views/profile_screen.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/bank_details.dart';
import 'package:studio_partner_app/src/feature/profile/views/edit_profile.dart';
import 'package:studio_partner_app/src/feature/profile/views/help.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/history_screen.dart';
import 'package:studio_partner_app/src/feature/transactions/views/upcoming_bills.dart';
import 'package:studio_partner_app/src/feature/transactions/views/withdrawal_history.dart';
import 'package:studio_partner_app/src/models/user_model.dart';
import '../src/feature/landing/views/landing_screen.dart';
import '../src/feature/auth/views/signup.dart';
import '../src/feature/transactions/views/transaction_history.dart';

class StudioRoutes {
  static const String splashScreen = '/';
  static const String loginViaEmailScreen = '/loginEmail';
  static const String loginViaPhone = '/loginPhone';
  static const String otpScreen = '/otp';
  static const String sendOtpScreen = '/sendOtp';
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
  static const String onboardingScreen = '/onboarding';
  static const String bankDetails = '/bankDetails';
  static const String previousComplaint = '/previousComplaint';
  static const String complaintDescription = '/complaintDescription';
  static const String customerReview = '/customerReview';
  static const String studioReview = '/studioReview';
  static const String memmbershipPayment = '/membershipPayment';
  static const String kycPage = '/kycPage';
  static const String transactionHistory = '/transactionHistory';
  static const String withdrawalHistory = '/withdrawalHistory';
  static const String upcomingBills = '/upcomingBills';
}

class StudioRouter {
  static final GoRouter router = GoRouter(
    initialLocation: StudioRoutes.splashScreen,
    routes: <RouteBase>[
      GoRoute(
          path: StudioRoutes.splashScreen,
          builder: (context, state) => const Splashscreen()),
      GoRoute(
        path: StudioRoutes.onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),
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
        path: StudioRoutes.loginViaPhone,
        builder: (BuildContext context, GoRouterState state) =>
            const SigninWithPhone(),
      ),
      GoRoute(
          path: StudioRoutes.sendOtpScreen,
          builder: (context, state) {
            final phoneNumber = state.extra as String;
            return SendOtp(
              phoneNumber: phoneNumber,
            );
          }),
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
            final profile = state.extra as User;
            return ProfileScreen(currentUser: profile);
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
          builder: (context, state) {
            final profile = state.extra as User;
            return EditProfile(currentUser: profile);
          }),
      GoRoute(
          path: StudioRoutes.historyScreen,
          builder: (context, state) => const HistoryPage()),
      GoRoute(
          path: StudioRoutes.bankDetails,
          builder: (context, state) => const BankDetails()),
      GoRoute(
          path: StudioRoutes.createProfileScreen,
          builder: (context, state) {
            return const CompleteProfileScreen();
          }),
      GoRoute(
          path: StudioRoutes.forgotPasswordScreen,
          builder: (context, state) => const ForgotPassword()),
      GoRoute(
          path: StudioRoutes.resetViaEmailScreen,
          builder: (context, state) => const RecoverPassEmail()),
      GoRoute(
          path: StudioRoutes.resetViaPhone,
          builder: (context, state) => const ResetPassSms()),
      GoRoute(
          path: StudioRoutes.verifyOtpScreen,
          builder: (context, state) => const VerifyOtp()),
      GoRoute(
        path: StudioRoutes.setNewPasswordScreen,
        builder: (context, state) => Setnewpass(),
      ),
      GoRoute(
          path: StudioRoutes.memmbershipPayment,
          builder: (context, state) {
            return const MembershipPayment();
          }),
      GoRoute(
          path: StudioRoutes.customerReview,
          builder: (context, state) => const CustomerReview()),
      GoRoute(
          path: StudioRoutes.studioReview,
          builder: (context, state) => const StudioReview()),
      GoRoute(
          path: StudioRoutes.previousComplaint,
          builder: (context, state) => PreviousComplaint()),
      GoRoute(
          path: StudioRoutes.complaintDescription,
          builder: (context, state) {
            final sno = state.extra as String;
            return ComplaintDescription(sno: sno);
          }),
      GoRoute(
          path: StudioRoutes.kycPage,
          builder: (context, state) => const KYCscreen()),
      GoRoute(
          path: StudioRoutes.transactionHistory,
          builder: (context, state) => TransactionHistory()),
      GoRoute(
          path: StudioRoutes.withdrawalHistory,
          builder: (context, state) => WithdrawalHistory()),
      GoRoute(
          path: StudioRoutes.upcomingBills,
          builder: (context, state) => UpcomingBills()),
    ],
  );
}
