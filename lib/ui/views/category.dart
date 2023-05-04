import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_admin_project/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/back_dialog_box.dart';
import '../widgets/custome_form_field.dart';

class CategoryItemScreen extends StatefulWidget {
  String type;
  CategoryItemScreen(this.type);

  @override
  State<CategoryItemScreen> createState() => _CategoryItemScreenState();
}

class _CategoryItemScreenState extends State<CategoryItemScreen> {
  TextEditingController _imgController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _categoryNameController = TextEditingController();

  // final _auth = FirebaseAuth.instance;
  CollectionReference usersForm =
      FirebaseFirestore.instance.collection('items');

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDADADA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Add New Category',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 400,
          color: const Color(0xFFFCFCFC),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  CustomText("Category name"),
                  customFormField(TextInputType.text, _categoryNameController,
                      context, "category-name", (value) {
                    if (value == null || value.isEmpty) {
                      return "this field can't be empty";
                    }

                    return null;
                  }),
                  CustomText("Title"),
                  customFormField(
                      TextInputType.text, _titleController, context, "title",
                      (value) {
                    if (value == null || value.isEmpty) {
                      return "this field can't be empty";
                    }

                    return null;
                  }),
                  CustomText("Url"),
                  customFormField(
                      TextInputType.text, _imgController, context, "url",
                      (value) {
                    if (value == null || value.isEmpty) {
                      return "this field can't be empty";
                    }

                    return null;
                  }),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        try {
                          usersForm.doc(widget.type).update({
                            'categories': FieldValue.arrayUnion([
                              {
                                'category_img': _imgController.text,
                                'category_name': _categoryNameController.text,
                                'title': _titleController.text,
                              }
                            ])
                          }).then((value) {
                            Get.snackbar('Congratulations',
                                "New Category Added Successfully");
                            _categoryNameController.clear();
                            _imgController.clear();
                            _titleController.clear();
                            // Get.back();
                          });
                        } catch (error) {
                          Get.snackbar("Error", error.toString());
                        }
                      } else {
                        Get.snackbar(
                            'Warning', 'Please Fillup All Input field');
                      }
                    },
                    child: const Center(
                        child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     getData();
                  //   },
                  //   child: Text("Get Data"),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackDialogBox();
        });
    return exitApp;
  }
}
