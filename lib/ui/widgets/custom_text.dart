import 'package:flutter/material.dart';

Widget CustomText(text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
