import 'package:flutter/material.dart';

Widget customeButton(
    String title,
    onPressed,
    ) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Material(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.amber,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.white,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 22),
          ),
        ),
      ),
    ),
  );
}