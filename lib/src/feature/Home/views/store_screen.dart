import 'package:studio_partner_app/src/feature/store/pages/add_warehouse.dart';
import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Warehouse',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),
              // Category buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CategoryButton(label: 'Dance', isActive: true),
                  CategoryButton(label: 'Photography', isActive: false),
                  CategoryButton(label: 'Misc.', isActive: false),
                  CategoryButton(label: 'Luxury', isActive: false),
                ],
              ),
              SizedBox(height: height * 0.02),
              // List of warehouses
              const WarehouseCard(
                title: 'Dance Warehouse',
                price: '₹ 50000/- Per Month',
                address:
                    'No. of Days 123, XYZ Apt., New Delhi, Delhi Pin - 123456',
                imageUrl:
                    'assets/images/frame.png', // Update with actual image path
              ),
              const WarehouseCard(
                title: 'Dance Warehouse',
                price: '₹ 50000/- Per Month',
                address:
                    'No. of Days 123, XYZ Apt., New Delhi, Delhi Pin - 123456',
                imageUrl:
                    'assets/images/frame.png', // Update with actual image path
              ),
              const WarehouseCard(
                title: 'Dance Warehouse',
                price: '₹ 50000/- Per Month',
                address:
                    'No. of Days 123, XYZ Apt., New Delhi, Delhi Pin - 123456',
                imageUrl:
                    'assets/images/frame.png', // Update with actual image path
              ),
              const WarehouseCard(
                title: 'Warehouse',
                price: '₹ 50000/- Per Month',
                address:
                    'No. of Days 123, XYZ Apt., New Delhi, Delhi Pin - 123456',
                imageUrl:
                    'assets/images/frame.png', // Update with actual image path
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddWarehouseRequest(),
            ),
          );
        },
        backgroundColor: AppColors.primaryBackgroundColor,
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isActive;

  const CategoryButton({super.key, 
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Reduced padding
      decoration: BoxDecoration(
        color:
            isActive ? AppColors.primaryBackgroundColor : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(
            16), // Reduced border radius for a smaller button
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 14, // Reduced font size
        ),
      ),
    );
  }
}

class WarehouseCard extends StatelessWidget {
  final String title;
  final String price;
  final String address;
  final String imageUrl; // Added imageUrl parameter

  const WarehouseCard({super.key, 
    required this.title,
    required this.price,
    required this.address,
    required this.imageUrl, // Added imageUrl parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              height: 100, // Adjust as needed
              width: 100, // Adjust as needed
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16), // Space between image and text
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
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
    );
  }
}
