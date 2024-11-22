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
                                icon: Icons.check_circle,
                                bankLogo: 'assets/images/hdfc.png',
                                selected: banks[index].primary,
                              );
                            },
                          ),
                        ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F6F9),
                      borderRadius: BorderRadius.circular(15),
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
                              builder: (context) => const AddBankdetails(),
                            ),
                          );
                        },
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
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(bankLogo),
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected
                  ? AppColors.primaryBackgroundColor
                  : Colors.grey.shade600,
            ),
            PopupMenuButton(
                color: Colors.white,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: onEditTap,
                      child: const Text('Edit'),
                    ),
                    PopupMenuItem(
                      onTap: onTap,
                      child: const Text('Delete'),
                    ),
                  ];
                }),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
