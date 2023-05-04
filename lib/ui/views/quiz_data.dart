import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fitness_admin_project/ui/widgets/custom_text.dart';
import 'package:fitness_admin_project/ui/widgets/custome_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Quizdata extends StatefulWidget {
  var categoryName;
  Quizdata(this.categoryName);

  @override
  State<Quizdata> createState() => _QuizdataState();
}

class _QuizdataState extends State<Quizdata> {
  final questionController = TextEditingController();
  final rightAnswerController = TextEditingController();
  final falseAnswerController1 = TextEditingController();
  final falseAnswerController2 = TextEditingController();
  final falseAnswerController3 = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("taste").child(widget.categoryName);
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: const Color(0xFFDADADA),
            // appBar: AppBar(
            //   backgroundColor: Colors.white,
            //   leading: IconButton(
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //       icon: const Icon(Icons.arrow_back, color: Colors.black)),
            // ),

            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FirebaseAnimatedList(
                        query: ref,
                        defaultChild: const Text('No Quiz Data Found'),
                        itemBuilder: (context, snapshot, animation, index) {
                          return ListTile(
                            title:
                                Text(snapshot.child('title').value.toString()),
                            trailing: IconButton(
                                onPressed: () {
                                  ref
                                      .child(snapshot
                                          .child('title')
                                          .value
                                          .toString()
                                          .capitalizeFirst!)
                                      .remove();
                                },
                                icon: const Icon(Icons.delete)),
                          );
                        }),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Container(
                    // height: 480,
                    width: 400,
                    color: const Color(0xFFFCFCFC),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: CustomText("Question")),
                            customFormField(
                                TextInputType.text,
                                questionController,
                                context,
                                'Add Question', (val) {
                              if (val == null || val.isEmpty) {
                                return "this field can't be empty";
                              }
                              return null;
                            }),
                            Center(child: CustomText("Options")),
                            CustomText("Right Answer"),
                            customFormField(
                                TextInputType.text,
                                rightAnswerController,
                                context,
                                'Right Answer', (val) {
                              if (val == null || val.isEmpty) {
                                return "this field can't be empty";
                              }
                              return null;
                            }),
                            CustomText("False Answer"),
                            customFormField(
                                TextInputType.text,
                                falseAnswerController1,
                                context,
                                'False Answer 1', (val) {
                              if (val == null || val.isEmpty) {
                                return "this field can't be empty";
                              }

                              return null;
                            }),
                            customFormField(
                                TextInputType.text,
                                falseAnswerController2,
                                context,
                                'False Answer 2', (val) {
                              if (val == null || val.isEmpty) {
                                return "this field can't be empty";
                              }

                              return null;
                            }),
                            customFormField(
                                TextInputType.text,
                                falseAnswerController3,
                                context,
                                'False Answer 3', (val) {
                              if (val == null || val.isEmpty) {
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
                                    setState(() {
                                      loading = true;
                                    });
                                    try {
                                      ref
                                          .child(questionController.text
                                              .toString()
                                              .capitalizeFirst!)
                                          .set({
                                        'title': questionController.text
                                            .toString()
                                            .capitalizeFirst,
                                        'options': {
                                          rightAnswerController.text
                                              .toString()
                                              .capitalize: true,
                                          falseAnswerController1.text
                                              .toString()
                                              .capitalize: false,
                                          falseAnswerController2.text
                                              .toString()
                                              .capitalize: false,
                                          falseAnswerController3.text
                                              .toString()
                                              .capitalize: false
                                        }
                                      }).then((value) {
                                        Get.snackbar('Congratulations',
                                            "New Questions Added Successfully");
                                        setState(() {
                                          loading = false;
                                        });
                                      }).onError((error, stackTrace) {
                                        Get.snackbar('Error', error.toString());
                                        setState(() {
                                          loading = false;
                                        });
                                      });

                                      questionController.clear();
                                      rightAnswerController.clear();
                                      falseAnswerController1.clear();
                                      falseAnswerController2.clear();
                                      falseAnswerController3.clear();
                                    } catch (e) {
                                      Get.snackbar("Error", e.toString());
                                    }
                                  } else {
                                    Get.snackbar('Warning',
                                        'Please Fillup All Input field');
                                  }
                                },
                                child: const Center(
                                    child: Text(
                                  'Add',
                                  style: TextStyle(color: Colors.white),
                                )))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
