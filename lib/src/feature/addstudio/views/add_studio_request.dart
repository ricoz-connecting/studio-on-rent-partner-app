import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/models/studio_model.dart';
import 'package:studio_partner_app/src/res/colors.dart';

import 'rent.dart';
import 'sell.dart';

class AddStudioRequest extends StatefulWidget {
  final Studio? studio;
  const AddStudioRequest({super.key, this.studio});

  @override
  State<AddStudioRequest> createState() => _AddStudioRequestState();
}

class _AddStudioRequestState extends State<AddStudioRequest>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Add Studio Request',
          style: GoogleFonts.inter(fontWeight: FontWeight.w500),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorPadding: const EdgeInsets.all(5),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppColors.primaryBackgroundColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
                tabs: const [
                  Tab(text: 'Rent'),
                  Tab(text: 'Sell'),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.83,
              width: double.infinity,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Rent(
                    studio: widget.studio,
                  ),
                  Sell(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
