import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscure;
  final TextInputType keyBoard;
  final FocusNode mFocusNode;
  final TextEditingController textEditingController;
  final TextCapitalization textCapitalization;
  final FormFieldValidator mValidation;
  final int maxLines;
  final VoidCallback onTap;
  final bool readOnly;
  final mOnSaved;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.obscure,
    required this.keyBoard,
    required this.mFocusNode,
    required this.textCapitalization,
    required this.mValidation,
    required this.maxLines,
    required this.onTap,
    this.readOnly = false,
    this.mOnSaved,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      // TODO: remove client-side validation errors when user enters the corrected info
      style: const TextStyle(
        height: 1.0,
        color: Colors.grey,
      ),
      maxLines: maxLines,
      readOnly: readOnly,
      textCapitalization: textCapitalization,
      focusNode: mFocusNode,
      controller: textEditingController,
      obscureText: obscure,
      keyboardType: keyBoard,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black, letterSpacing: 1),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        // contentPadding: EdgeInsets.all(15.0),
      ),
      validator: mValidation,
      onSaved: (String? value) {
        // save input value
        mOnSaved(value);
      },
    );
  }
}
