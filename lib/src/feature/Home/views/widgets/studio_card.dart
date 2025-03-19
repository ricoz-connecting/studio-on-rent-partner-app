import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/models/studio_model.dart';

class StudioCard extends StatefulWidget {
  final String title;
  final List<Price> price;
  final int basePricePerHour;
  final int fullDayPrice;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final String imageUrl;
  final bool status;

  final Function()? onTap, setStatus, onTapEdit, onCardTap;

  const StudioCard({
    super.key,
    required this.onCardTap,
    required this.onTapEdit,
    required this.setStatus,
    required this.onTap,
    required this.status,
    required this.title,
    required this.price,
    required this.basePricePerHour,
    required this.fullDayPrice,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.imageUrl,
  });

  @override
  State<StudioCard> createState() => _StudioCardState();
}

class _StudioCardState extends State<StudioCard> {
  int _currentIndex = 0;
  late Timer _timer;
  String convertPeriod(String period) {
    switch (period) {
      case 'Hourly Rent':
        return 'Per Hour';
      case 'Monthly Rent':
        return 'Per Month';
      case 'Weekly Rent':
        return 'Per Week';
      default:
        return 'Per Day';
    }
  }

  void _startAnimationLoop() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.price.length;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startAnimationLoop();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: widget.onCardTap,
        child: Container(
          height: h * 0.15,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6F9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Image.network(
                  widget.imageUrl,
                  height: double.infinity,
                  width: w * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: h * 0.01),
                    Text(
                      widget.title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: widget.status == true
                            ? const Color(0xFF2B9721)
                            : const Color(0xFFA71414),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.status == true ? 'Active' : 'Close',
                        style: const TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "₹ ${widget.basePricePerHour.toStringAsFixed(2)} Per Hour",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // AnimatedSwitcher(
                    //   duration: const Duration(milliseconds: 1),
                    //   switchInCurve: Curves.easeInOut,
                    //   switchOutCurve: Curves.easeInOut,
                    //   transitionBuilder: (child, animation) {
                    //     return FadeTransition(
                    //       opacity: animation,
                    //       child: child,
                    //     );
                    //   },
                    //   child: Text(
                    //     '₹${widget.price[_currentIndex].amount}/- ${convertPeriod(widget.price[_currentIndex].title!)}',
                    //     key: ValueKey<int>(_currentIndex),
                    //     style: GoogleFonts.poppins(
                    //       color: Colors.black54,
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.street}, ${widget.city}, ${widget.state}, ${widget.pincode}',
                      style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                color: Colors.white,
                padding: EdgeInsets.zero,
                offset: const Offset(0, 40),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: widget.onTapEdit,
                      child: const Text('Edit'),
                    ),
                    PopupMenuItem(
                      onTap: widget.setStatus,
                      child: Text('Set ${widget.status ? 'Close' : 'Active'}'),
                    ),
                    PopupMenuItem(
                      onTap: widget.onTap,
                      child: const Text('Delete'),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
