import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar(
      {super.key,
      required this.icons,
      required this.emailText,
      required this.colors,
      required this.profileImage});
  
  final String emailText;
  final Icon icons;
  final Color colors;
  final ImageProvider profileImage;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var chatAppSearchController = TextEditingController();
    
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + 10, 
        left: 6,
        right: 6,
      ),
      child: Row(
        children: [
          // Search Bar
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(81),
                color: colors,
              ),
              height: height * 0.062,
              child: TextField(
                controller: chatAppSearchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: icons,
                  hintText: emailText,
                  hintStyle: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.02,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10), 
          CircleAvatar(
            backgroundImage: profileImage,
            radius: height * 0.03, 
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(height * 0.03),
                onTap: () {
                  // Add profile button action here
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
