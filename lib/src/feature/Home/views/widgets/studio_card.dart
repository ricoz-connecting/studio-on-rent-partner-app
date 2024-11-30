import 'dart:async';

import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/models/studio_model.dart';

class StudioCard extends StatefulWidget {
  final String title;
  final List<Price> price;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final String imageUrl;
  final bool status;
  final Function()? onTap, setStatus, onTapEdit;

  const StudioCard({
    super.key,
    required this.onTapEdit,
    required this.setStatus,
    required this.onTap,
    required this.status,
    required this.title,
    required this.price,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.only(bottom: 5.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6F9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.imageUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
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
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        PopupMenuButton(
                            color: Colors.white,
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  onTap: widget.onTapEdit,
                                  child: const Text('Edit'),
                                ),
                                PopupMenuItem(
                                  onTap: widget.setStatus,
                                  child: Text(
                                      'Set ${widget.status ? 'Close' : 'Active'}'),
                                ),
                                PopupMenuItem(
                                  onTap: widget.onTap,
                                  child: const Text('Delete'),
                                ),
                              ];
                            }),
                      ],
                    ),
                    const SizedBox(height: 4),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: Text(
                        '₹${widget.price[_currentIndex].amount}/- ${convertPeriod(widget.price[_currentIndex].title!)}',
                        key: ValueKey<int>(_currentIndex),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.street}, ${widget.city}, ${widget.state}, ${widget.pincode}',
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
