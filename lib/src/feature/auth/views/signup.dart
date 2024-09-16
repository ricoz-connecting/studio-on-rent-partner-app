import 'package:studio_partner_app/src/feature/auth/controllers/signup.dart';
import 'package:studio_partner_app/src/feature/auth/views/login_screen.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/login_via_google.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureText = true;
  bool _obscureTextConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
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
                TextField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 14,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Rishav Bhardwaz',
                  ),
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
                TextField(
                  controller: _emailController,
                  onChanged: (value) {
                    setState(() {
                      _emailController.text = value;
                    });
                  },
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 14,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'example@gmail.com',
                  ),
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
                TextField(
                  controller: _passwordController,
                  onChanged: (value) => setState(() {
                    _passwordController.text = value;
                  }),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 14,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: _obscureText
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    hintText: '********',
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
                TextField(
                  controller: _confirmPasswordController,
                  onChanged: (value) => setState(() {
                    _confirmPasswordController.text = value;
                  }),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  obscureText: _obscureTextConfirm,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 14,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureTextConfirm = !_obscureTextConfirm;
                          });
                        },
                        child: _obscureTextConfirm
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    hintText: '********',
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBackgroundColor,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90),
                        ),
                      ),
                      onPressed: () {
                        SignupEmail(
                                context: context,
                                email: _emailController.text,
                                password: _passwordController.text,
                                confirmPassword:
                                    _confirmPasswordController.text)
                            .signUpEmail();
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
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
                const LoginViaGoogleOrApple(),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
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
