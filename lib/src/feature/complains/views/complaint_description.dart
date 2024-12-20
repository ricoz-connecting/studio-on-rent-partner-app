import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ComplaintDescription extends StatelessWidget {
  final Map<String, dynamic> complaint;
  const ComplaintDescription({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = complaint['isoDate'];
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedDate);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '#${complaint['sno']}',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Subject'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(complaint['subject']),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Date/ Time of Complaint'),
                const Spacer(),
                Text(formattedDate,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Description'),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(complaint['description']),
            ),
            const SizedBox(height: 10),
            const Text('Images'),
            const SizedBox(height: 10),
            Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: NetworkImage(complaint['images'])),
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: complaint['images'] == ''
                        ? const Icon(
                            Icons.image,
                            size: 40,
                            color: Colors.grey,
                          )
                        : null)),
            const SizedBox(height: 10),
            const Text('Admins Reply'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.'),
            ),
          ],
        ),
      ),
    );
  }
}
