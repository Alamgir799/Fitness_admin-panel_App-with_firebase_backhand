import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BackDialogBox extends StatelessWidget {
  const BackDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        "Are you sure want to close application?",
        style: TextStyle(fontSize: 14),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text("No"),
        ),
        TextButton(
          onPressed: () {
            //Get.toNamed(login);
          },
          child: Text("Yes"),
        ),
      ],
    );
  }
}
