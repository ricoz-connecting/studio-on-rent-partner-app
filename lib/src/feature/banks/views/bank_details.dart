import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/banks/controller/bank_controller.dart';
import 'package:studio_partner_app/src/feature/banks/views/add_bankdetails.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class BankDetails extends ConsumerStatefulWidget {
  const BankDetails({super.key});

  @override
  ConsumerState<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends ConsumerState<BankDetails> {
  bool isLoading = true;
  @override
  void initState() {
    getBanks();
    super.initState();
  }

  Future<void> getBanks() async {
    await ref.read(bankControllerProvider.notifier).getBankDetails();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final banks = ref.watch(bankControllerProvider);

    return isLoading == true
        ? const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'Bank Details',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
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
                  banks.isEmpty
                      ? const SizedBox()
                      : Expanded(
                          child: ListView.builder(
                            itemCount: banks.length,
                            itemBuilder: (context, index) {
                              return buildBankCard(
                                onEditTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddBankdetails(
                                        bankDetails: banks[index],
                                      ),
                                    ),
                                  );
                                },
                                onTap: () {
                                  ref
                                      .read(bankControllerProvider.notifier)
                                      .deleteBankDetail(
                                        context: context,
                                        bankId: banks[index].id,
                                      );
                                },
                                context,
                                bankName: banks[index].bankName,
                                accountNumber: banks[index].accountNumber,
                                icon: Icons.verified,
                                bankLogo: 'assets/images/bank.png',
                                selected: banks[index].primary,
                              );
                            },
                          ),
                        ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddBankdetails(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F6F9),
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Icon(
                            Icons.add,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget buildBankCard(
    BuildContext context, {
    required String bankName,
    required String accountNumber,
    required IconData icon,
    required String bankLogo,
    required Function()? onTap,
    required Function()? onEditTap,
    bool selected = false,
  }) {
    return Card(
      color: const Color(0xFFF4F6F9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: selected ? 4 : 0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circle Avatar
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.asset(
                  bankLogo,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Bank Name & Account Number
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 18,
                        color: selected
                            ? AppColors.primaryBackgroundColor
                            : Colors.grey.shade600,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          bankName,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'A/c No. $accountNumber',
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Trailing Popup Menu
            PopupMenuButton(
              color: Colors.white,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: onEditTap,
                    child: Text(
                      'Edit',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: onTap,
                    child: Text(
                      'Delete',
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }
}
