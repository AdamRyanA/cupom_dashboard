import 'package:cupom_dashboard/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputCustom extends StatelessWidget {

  final bool? obscure;
  final bool? autofocus;
  final FocusNode? focusNode;
  final bool? prefixBool;
  final bool? suffixObscure;
  final Function()? onPressedObscure;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hint;
  final String label;
  final bool? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? Function(String?)? onFieldSubmitted;

  const InputCustom({Key? key, required this.controller, this.keyboardType, required this.hint, this.validator, this.obscure = false, this.maxLines, this.inputFormatters, required this.label, this.onPressedObscure, this.suffixObscure = false, this.prefixBool = false, this.focusNode, this.autofocus = false, this.onFieldSubmitted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: subtitle2,),
        const SizedBox(height: 8),
        Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TextFormField(
              autofocus: autofocus!,
              focusNode: focusNode,
              obscureText: obscure!,
              controller: controller,
              style: body2.copyWith(color: blackColor),
              maxLines: maxLines != true ? 1 : null ,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType ?? TextInputType.text,
              cursorColor: blackColor60,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: greyNeutro60Color),
                    borderRadius: BorderRadius.circular(14)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: greyNeutro60Color),
                    borderRadius: BorderRadius.circular(14)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: greyNeutro60Color),
                    borderRadius: BorderRadius.circular(14)
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                hintText: hint,
                hintStyle: body2.copyWith(color: blackColor60),
                prefixIcon: prefixBool! ? Padding(
                  padding: const EdgeInsets.fromLTRB(12, 11, 0, 0),
                  child: Text(
                    '+55',
                    style: body2.copyWith(color: blackColor60),
                  ),
                ) : null,
                suffixIcon: suffixObscure!
                    ? IconButton(
                  onPressed: onPressedObscure,
                  icon: Icon(
                      obscure! ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: blackColor60
                  ),
                )
                    : null,
              ),
              validator: validator,
              onFieldSubmitted: onFieldSubmitted,
            )),
      ],
    );
  }
}
