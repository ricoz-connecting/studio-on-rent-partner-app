import 'package:flutter/material.dart';

class CustomErrorBox {
  static  showErrorBox(
      BuildContext context, String message, VoidCallback onPressed) {
    showDialog(
        context: context,
        builder: (context) => Dialog.fullscreen(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                height: 300,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        message,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: CloseButton(
                        onPressed: onPressed,
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
