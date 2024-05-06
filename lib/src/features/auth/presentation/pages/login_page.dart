// ignore_for_file: public_member_api_do
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/commons/views/location_access/location_access_page.dart';
import 'package:studio_partner_app/src/commons/views/otp/login_otp.dart';
import 'package:studio_partner_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:studio_partner_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:studio_partner_app/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:studio_partner_app/src/features/auth/presentation/widgets/header_builder.dart';
import 'package:studio_partner_app/src/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';
import 'package:studio_partner_app/src/utils/widgets/form_text_field.dart';

import '../widgets/social_login_buttons.dart';

class LoginPage extends StatefulWidget {
  static String routePath = '/login-page';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // backgroundColor: ColorAssets.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  // TODO: implement listener
                  // if (state is AuthFailure) {
                  //   ScaffoldMessenger.of(context)
                  //       .showSnackBar(SnackBar(content: Text(state.message)));
                  // }
                  // if (state is AuthSuccess) {
                  //   user = state.user;
                  //   context.go(HomeView.routePath);
                  // }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AuthenticationPageHeaderBuilder(
                          title: "Login",
                          subtitle: "Hi! Welcome back, nice to see you"),
                      _formFields(context),
                      CustomTextButton(
                          text: "Sign In",
                          ontap: () {
                            // context.read<AuthBloc>().add(LoginEvent(
                            //     params: LogInParams(
                            //         email: emailEditingController.text.trim(),
                            //         password: passwordEditingController.text
                            //             .trim())));
                            context.push(LocationAccessPage.routePath);
                          }),
                      SocialAuthenticationButtons(
                        widget: RichText(
                          text: TextSpan(
                              text: "Don't have account",
                              style: textTheme.titleLarge!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.push(SignUpPage.routePath);
                                    },
                                  text: " Sign Up",
                                  style: textTheme.titleLarge!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                )
                              ]),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  _formFields(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FormTextField(
          controller: emailEditingController,
          labelText: 'Email',
          hintText: "example@gmail.com",
        ),
        FormTextField(
          controller: passwordEditingController,
          hintText: ' - - - - - - - - - - ',
          enableObsecure: true,
          labelText: 'Password',
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Text(
              "Login with OTP",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ).onTap(() {
              context.push(LoginOtp.routePath);
            }),
          ),
        )
      ],
    ).addSpacingBetweenElements(12);
  }
}
