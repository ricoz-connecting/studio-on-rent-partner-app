// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:studio_partner_app/commons/views/widgets/custom_appbar.dart';
// import 'package:studio_partner_app/src/feature/transactions/views/widgets/withdrawal_hitsory_widget.dart';
// import '../controllers/withdrawal_history_controller.dart';

// class WithdrawalHistoryPage extends ConsumerStatefulWidget {
//   const WithdrawalHistoryPage({super.key});

//   @override
//   ConsumerState<WithdrawalHistoryPage> createState() =>
//       _WithdrawalHistoryPageState();
// }

// class _WithdrawalHistoryPageState extends ConsumerState<WithdrawalHistoryPage> {
//   @override
//   void initState() {
//     super.initState();
//     _fetchWithdrawalHistory();
//   }

//   Future<void> _fetchWithdrawalHistory() async {
//     await ref
//         .read(withdrawalHistoryControllerProvider.notifier)
//         .getWithdrawHistory(context: context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final withdrawalHistory = ref.watch(withdrawalHistoryControllerProvider);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const CustomAppBar(
//         title: 'Withdrawal History',
//       ),
//       body: withdrawalHistory.isEmpty
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: ListView.builder(
//                 itemCount: withdrawalHistory.length,
//                 itemBuilder: (context, index) {
//                   return WithdrawalHistoryWidget(
//                     withdrawalHistory: withdrawalHistory[index],
//                   );
//                 },
//               ),
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:studio_partner_app/commons/views/widgets/custom_appbar.dart';
import 'package:studio_partner_app/src/feature/transactions/views/widgets/withdrawal_hitsory_widget.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import '../controllers/withdrawal_history_controller.dart';

class WithdrawalHistoryPage extends ConsumerStatefulWidget {
  const WithdrawalHistoryPage({super.key});

  @override
  ConsumerState<WithdrawalHistoryPage> createState() =>
      _WithdrawalHistoryPageState();
}

class _WithdrawalHistoryPageState extends ConsumerState<WithdrawalHistoryPage> {
  bool isLoading = true; // Add loading flag

  @override
  void initState() {
    super.initState();
    _fetchWithdrawalHistory();
  }

  Future<void> _fetchWithdrawalHistory() async {
    await ref
        .read(withdrawalHistoryControllerProvider.notifier)
        .getWithdrawHistory(context: context);
    setState(() {
      isLoading = false; // Set loading to false after fetching
    });
  }

  @override
  Widget build(BuildContext context) {
    final withdrawalHistory = ref.watch(withdrawalHistoryControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Withdrawal History',
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : withdrawalHistory.isEmpty
              ? Center(
                  child: Lottie.asset(
                    AnimationAssets.noDataFound,
                    width: 200,
                    height: 200,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: withdrawalHistory.length,
                    itemBuilder: (context, index) {
                      return WithdrawalHistoryWidget(
                        withdrawalHistory: withdrawalHistory[index],
                      );
                    },
                  ),
                ),
    );
  }
}
