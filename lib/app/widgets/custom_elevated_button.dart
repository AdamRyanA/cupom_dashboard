import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool loading;
const CustomElevatedButton({
  super.key,
  required this.text,
  this.onPressed,
  this.loading = false,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      width: 300,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: blackColor,
            backgroundColor: !loading ? primaryColor : Colors.grey,
            disabledBackgroundColor: Colors.grey,
            disabledForegroundColor: blackColor,
          ),
          child: Row(
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text("Entrar",
                      style: GoogleFonts.fredoka(
                          fontWeight: FontWeight.w500,
                          fontSize: 18
                      ),
                    ),
                  ),
                ),
              ]
          )
      ),
    );
  }
}