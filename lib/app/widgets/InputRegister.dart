import 'package:cupom_dashboard/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class InputRegister extends StatelessWidget {

  final Color colorCard;
  final Color colorText;
  final String? texto;
  final String? hintText;
  TextInputType keyboardType;
  Color buttonBackground;
  String? Function(String?)? validator;
  IconData? prefixIcon;
  String prefix;
  TextEditingController? controllerName = TextEditingController();
  List<TextInputFormatter>? format;
  void Function(String)? onChange;
  String? onError;
  bool enabled;
  bool checkEnable;
  bool textCapitalizationTrue;
  bool autofocus;
  bool password;
  Function(String)? onSubmitted;
  int maxLines;
  double sizeWidth;

  InputRegister({super.key,
    @required this.texto,
    @required this.controllerName,
    this.hintText = "Digite aqui...",
    this.colorCard = Colors.white,
    this.colorText = Colors.black,
    this.autofocus = true,
    this.buttonBackground = Colors.white60,
    this.textCapitalizationTrue = false,
    this.format,
    this.prefixIcon,
    this.prefix = "",
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
          child: SizedBox(
            width: sizeWidth,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                "$texto",
                style: GoogleFonts.fredoka(
                    color: colorText,
                    fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: SizedBox(
            width: sizeWidth,
            child: Semantics(
              label: texto,
              hint: hintText,
              textField: true,
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
          ),
        ),
      ],
    );
  }
}
