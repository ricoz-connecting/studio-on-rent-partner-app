
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/commons/views/appbar.dart';

class EarningsPage extends ConsumerWidget {
  const EarningsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final status = ref.watch(statusProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar.buildAppBar(context, ref),
      body: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0), // Reduced padding
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '₹ 1000',
                              style: GoogleFonts.lato(
                                fontSize: 20, // Reduced font size
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Today's Earnings",
                              style: GoogleFonts.lato(
                                fontSize: 14, // Reduced font size
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      DropdownButton<String>(
                        value: 'Today',
                        icon: const Icon(Icons.arrow_drop_down),
                        underline: Container(),
                        items: const [
                          DropdownMenuItem(
                              value: 'Today', child: Text('Today')),
                          DropdownMenuItem(
                              value: 'In past 1 Month',
                              child: Text('In past 1 Month')),
                          DropdownMenuItem(
                              value: 'In past 3 Month',
                              child: Text('In past 3 Month')),
                        ],
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    children: [
                      _buildInfoCard('13', 'New One Time Orders'),
                      _buildInfoCard('2', 'New Subscription Orders'),
                      _buildInfoCard('34', 'Subscription Orders Delivered'),
                      _buildInfoCard('39', 'Total Subscription Orders'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  Text(
                    "Transaction History",
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTransactionTile(
                      '12345', 'Warehouse Service', '+ ₹6000'),
                  _buildTransactionTile(
                      '678137916388', 'Withdrawal to XXXX2010', '- ₹500'),
                  _buildTransactionTile(
                      '12345', 'Warehouse Service', '+ ₹6000'),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoCard(String number, String title) {
    return Container(
      padding: const EdgeInsets.all(12.0), 
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: GoogleFonts.lato(
              fontSize: 20, // Reduced font size
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.lato(
              fontSize: 14, // Reduced font size
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(String id, String title, String amount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ID : $id',
            style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.lato(fontSize: 16, color: Colors.black),
              ),
              Text(
                amount,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: amount.startsWith('+') ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}