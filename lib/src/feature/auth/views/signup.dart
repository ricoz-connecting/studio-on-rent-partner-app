import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/feature/auth/controllers/auth_controller.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/login_via_google.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/utils/router.dart';

import 'widgets/auth_text_field.dart';
import 'widgets/reusable_button.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool _obscureText = true;
  bool _obscureTextConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Create Your Account',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const AuthTextField(
                  hintText: 'Rishav Bhardwaz',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                AuthTextField(
                  hintText: "Enter Your Email",
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                AuthTextField(
                  obscureText: _obscureText,
                  hintText: '********',
                  onChanged: (value) => setState(() {
                    password = value;
                  }),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: _obscureText
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                AuthTextField(
                  obscureText: _obscureTextConfirm,
                  hintText: '********',
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureTextConfirm = !_obscureTextConfirm;
                        });
                      },
                      child: _obscureTextConfirm
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                  onChanged: (value) => setState(() {
                    confirmPassword = value;
                  }),
                ),
                const SizedBox(height: 30),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return ReusableButton(
                      label: 'Sign Up',
                      onPressed: () {
                        ref
                            .read(authControllerProvider.notifier)
                            .signUpUsingEmailPass(
                              context: context,
                              email: email,
                              password: password,
                            );
                        // SignupEmail(
                        //         context: context,
                        //         email: email,
                        //         password: password,
                        //         confirmPassword: confirmPassword)
                        //     .signUpEmail();
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('or sign up with'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const LoginViaGoogleOrPhone(),
                Center(
                  child: TextButton(
                    onPressed: () {
                      GoRouter.of(context)
                          .push(StudioRoutes.loginViaEmailScreen);
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                                color: AppColors.primaryBackgroundColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
