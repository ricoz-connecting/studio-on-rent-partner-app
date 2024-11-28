import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/transactions/views/widgets/withdrawal_hitsory_widget.dart';

import '../controllers/withdrawal_history_controller.dart';

class WithdrawalHistoryPage extends ConsumerStatefulWidget {
  const WithdrawalHistoryPage({super.key});

  @override
  ConsumerState<WithdrawalHistoryPage> createState() =>
      _WithdrawalHistoryState();
}

class _WithdrawalHistoryState extends ConsumerState<WithdrawalHistoryPage> {
  bool isLoading = true;
  @override
  void initState() {
    _getWithdrawalHistory();
    super.initState();
  }

  Future<void> _getWithdrawalHistory() async {
    await ref
        .read(withdrawalHistoryControllerProvider.notifier)
        .getWithdrawHistory(context: context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final withdrawalHistory = ref.watch(withdrawalHistoryControllerProvider);
    return isLoading == true
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Withdrawal History',
                style: GoogleFonts.lato(),
              ),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Withdrawal History',
                style: GoogleFonts.lato(),
              ),
            ),
            body: ListView.builder(
                itemCount: withdrawalHistory.length,
                itemBuilder: (context, index) {
                  return WithdrawalHistoryWidget(
                    withdrawalHistory: withdrawalHistory[index],
                  );
                }),
          );
  }
}
