import 'package:flutter/material.dart';

Widget customFormField(
  keyboardtype,
  controller,
  context,
  hinttext,
  validator, {
  bool obscureText = false,
  suffixIcon,
  prefixIcon,
  prefixStyle,
  readOnly = false,
  onChanged
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: SizedBox(
     // height: 45,
      width: MediaQuery.of(context).size.width / 2,
      child: TextFormField(
        keyboardType: keyboardtype,
        readOnly: readOnly,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        textInputAction: TextInputAction.next,
        validator: validator,
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 20, 15),
          suffixIcon: suffixIcon,
          prefix: prefixIcon,
          prefixStyle: prefixStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber),
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
          ),
          hintText: hinttext,
          hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
  );
}
