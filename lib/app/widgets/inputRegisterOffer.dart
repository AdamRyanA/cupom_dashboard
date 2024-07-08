import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class InputRegisterOffer extends StatelessWidget {
  final Color colorCard;
  final Color colorText;
  final String texto;
  final String? hintText;
  final TextInputType keyboardType;
  final Color buttonBackground;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final TextEditingController controllerName;
  final List<TextInputFormatter>? format;
  final void Function(String)? onChange;
  final String? onError;
  final bool enabled;
  final bool checkEnable;
  final bool textCapitalizationTrue;
  final bool autofocus;
  final bool password;
  final Function(String)? onSubmitted;
  final int maxLines;
  final double sizeWidth;

  const InputRegisterOffer({super.key,
    required this.texto,
    required this.controllerName,
    this.hintText = "Digite aqui...",
    this.colorCard = Colors.white,
    this.colorText = Colors.black,
    this.autofocus = true,
    this.buttonBackground = Colors.white60,
    this.textCapitalizationTrue = false,
    this.format,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChange,
    this.onError,
    this.enabled = true,
    this.checkEnable = false,
    this.password = false,
    this.onSubmitted,
    this.maxLines = 1,
    this.sizeWidth = 300
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    texto,
                    style: GoogleFonts.fredoka(
                      color: colorText,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              )
            ],
          )
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: Semantics(
            label: texto,
            hint: hintText,
            textField: true,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controllerName,
                    autofocus: autofocus,
                    keyboardType: keyboardType,
                    inputFormatters: format,
                    style: const TextStyle(fontSize: 12),
                    validator: validator,
                    obscureText: password,
                    onFieldSubmitted: onSubmitted,
                    onChanged: onChange,
                    maxLines: maxLines,
                    decoration: InputDecoration(
                      errorText: onError,
                      prefix: prefixIcon,
                      contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      hintText: hintText,
                      enabled: enabled,
                      filled: true,
                      fillColor: enabled ? Colors.white : Colors.grey[400],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: primaryColor)
                      ),
                    ),
                  ),
                ),
                maxLines == 1 ? Expanded(
                  child: Container(),
                ) : Container()
              ],
            )
          ),
        ),
      ],
    );
  }
}
