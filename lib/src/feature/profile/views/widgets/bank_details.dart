import 'package:studio_partner_app/src/feature/profile/views/widgets/add_bankdetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class BankDetails extends StatelessWidget {
  const BankDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Bank Details',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select or Add bank details:',
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            _buildBankCard(
              context,
              bankName: 'John Doe',
              accountNumber: 'XXXX XXXX 1345',
              icon: Icons.check_circle,
              bankLogo: 'assets/sbi_logo.png', // Replace with actual asset path
              selected: true,
            ),
            const SizedBox(height: 10),
            _buildBankCard(
              context,
              bankName: 'John Doe',
              accountNumber: 'XXXX XXXX 5431',
              icon: Icons.add_circle_outline,
              bankLogo:
                  'assets/axis_logo.png', // Replace with actual asset path
              selected: false,
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: IconButton(
                  iconSize: 30,
                  icon: Icon(
                    Icons.add,
                    color: Colors.grey.shade700,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BankDetailss(),
                      ),
                    );

                    // Add new bank account logic here
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankCard(
    BuildContext context, {
    required String bankName,
    required String accountNumber,
    required IconData icon,
    required String bankLogo,
    bool selected = false,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: selected ? 4 : 0,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(bankLogo), // Bank logo image
          backgroundColor: Colors.transparent,
        ),
        title: Text(
          bankName,
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          'A/c No. $accountNumber',
          style: GoogleFonts.lato(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: Icon(
          icon,
          color: selected
              ? AppColors.primaryBackgroundColor
              : Colors.grey.shade600,
        ),
        onTap: () {
          // Handle card tap
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: BankDetails()));
}
