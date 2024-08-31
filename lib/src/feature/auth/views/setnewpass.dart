import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_strength_indicator/password_strength_indicator.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class Setnewpass extends StatefulWidget {
  Setnewpass({super.key});

  @override
  State<Setnewpass> createState() => _SetnewpassState();
}

class _SetnewpassState extends State<Setnewpass> {
  bool _obscureText = true;
  bool _obscureTextconfirm = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set New Password',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter new strong and secure password that protects your account',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) => setState(() {
                _passwordController.text = value;
              }),
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 14,
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                hintText: 'New Password',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmPassController,
              obscureText: _obscureTextconfirm,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureTextconfirm = !_obscureTextconfirm;
                    });
                  },
                  child: Icon(
                    _obscureTextconfirm
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 14,
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                hintText: 'Confirm Password',
              ),
            ),
            const SizedBox(height: 20),
            PasswordStrengthIndicator(
              password: _passwordController.text,
              colors: const StrengthColors(
                weak: Colors.orange,
                medium: Colors.yellow,
                strong: Colors.green,
              ),
              style: StrengthBarStyle.dashed,
              strengthBuilder: (String password) {
                if (password.length < 8) {
                  return 0;
                }
                if (password.contains(RegExp(r'[A-Z]')) &&
                    password.contains(RegExp(r'[a-z]')) &&
                    password.contains(RegExp(r'[0-9]')) &&
                    password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                  return 1;
                }
                return password.length / 10;
              },
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.info,
                  color: Colors.grey,
                ),
                SizedBox(width: 10),
                Text('Password must be at least 8 characters long'),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.info,
                  color: Colors.grey,
                ),
                SizedBox(width: 10),
                Text('Contain at least one number'),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.primaryBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'CONTINUE',
                    style: GoogleFonts.inter(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
