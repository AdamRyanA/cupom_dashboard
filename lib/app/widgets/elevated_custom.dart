import 'package:cupom_dashboard/app/utils/utils.dart';
import 'package:flutter/material.dart';

class ElevatedCustom extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const ElevatedCustom(
      {super.key, required this.text, this.backgroundColor, this.foregroundColor, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
      ),
      child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    text,
                    style: button.copyWith(color: blackColor87)
                  ),
                ),
              )
            ],
          )),
    );
  }
}