
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatRoomAppBar extends StatelessWidget {
  const ChatRoomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.08,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/owner_img.png'),
            radius: 25,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.04),
            width: MediaQuery.sizeOf(context).width * 0.58,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID : 12345',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 18,
                        letterSpacing: 0.13,
                        color: BasicColor.deepBlack,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                    size: 30,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
