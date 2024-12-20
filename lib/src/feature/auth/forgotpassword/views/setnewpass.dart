import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_strength_indicator/password_strength_indicator.dart';
import 'package:studio_partner_app/src/feature/auth/forgotpassword/controller/recover_password_controller.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/reusable_button.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/textfield.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class Setnewpass extends StatefulWidget {
  Setnewpass({super.key});

  @override
  State<Setnewpass> createState() => _SetnewpassState();
}

class _SetnewpassState extends State<Setnewpass> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isPasswordObscured = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Forgot Password',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            // Wrapping fields in a Form widget
            key: _formKey, // Set the formKey here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Set New Password',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Enter new strong and secure password that protects your account',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                ReusableAuthTextField(
                  controller: _passwordController,
                  hintText: 'Enter Password',
                  obscureText: _isPasswordObscured,
                  suffixIcon: Icon(
                    _isPasswordObscured
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onSuffixIconTap: () {
                    setState(() {
                      _isPasswordObscured = !_isPasswordObscured;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                ReusableAuthTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Enter Confirm Password',
                  obscureText: _isPasswordObscured,
                  suffixIcon: Icon(
                    _isPasswordObscured
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onSuffixIconTap: () {
                    setState(() {
                      _isPasswordObscured = !_isPasswordObscured;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm password is required';
                    } else if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, child) {
                    return Center(
                      child: ReusableButton(
                        // isLoading: _isLoading,
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            await ref
                                .read(recoverControllerProvider.notifier)
                                .setNewPassword(
                                  newPassword: _passwordController.text,
                                  phone: _phoneController.text,
                                  context: context,
                                );
                          } else {
                            print('Form validation failed');
                          }
                        },
                        label: 'Set New Password',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
