import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness_admin_project/ui/views/quiz_data.dart';
import 'package:fitness_admin_project/ui/widgets/custom_text.dart';
import 'package:fitness_admin_project/ui/widgets/custome_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../business_logics/quiz_database.dart';
import '../route/route.dart';

class QuizCategoryScreen extends StatefulWidget {
  @override
  State<QuizCategoryScreen> createState() => _QuizCategoryScreenState();
}

class _QuizCategoryScreenState extends State<QuizCategoryScreen> {
  var db = DBconnect();

  late Future _categorys;
  Future<List> getData() async {
    return db.fetchCategoryList();
  }

  final TextEditingController _categoryNameController = TextEditingController();
  final questionController = TextEditingController();
  final rightAnswerController = TextEditingController();
  final falseAnswerController1 = TextEditingController();
  final falseAnswerController2 = TextEditingController();
  final falseAnswerController3 = TextEditingController();
  DatabaseReference ref = FirebaseDatabase.instance.ref("taste");

  @override
  void initState() {
    _categorys = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _categorys as Future<List>,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              return Scaffold(
                floatingActionButton: FloatingActionButton.extended(
                    onPressed: () {
                      Get.to(const AddNewQuizCategoryScreen());
                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return SizedBox(
                      //         width: MediaQuery.of(context).size.width / 2,
                      //         child: Dialog(
                      //           child: Column(
                      //             children: [
                      //               Center(child: CustomText("Category")),
                      //               TextField(
                      //                 controller: _categoryNameController,
                      //               ),
                      //               Center(child: CustomText("Question")),
                      //               TextField(
                      //                 controller: questionController,
                      //               ),
                      //               Center(child: CustomText("Options")),
                      //               CustomText("Right Answer"),
                      //               TextField(
                      //                 controller: rightAnswerController,
                      //               ),
                      //               CustomText("False Answer"),
                      //               TextField(
                      //                 controller: falseAnswerController1,
                      //               ),
                      //               TextField(
                      //                 controller: falseAnswerController2,
                      //               ),
                      //               TextField(
                      //                 controller: falseAnswerController3,
                      //               ),
                      //               ElevatedButton(
                      //                   onPressed: () {
                      //                     ref.update({
                      //                       _categoryNameController.text
                      //                           .toString(): {
                      //                         questionController.text
                      //                             .toString()
                      //                             .capitalizeFirst!: {
                      //                           'title': questionController.text
                      //                               .toString()
                      //                               .capitalizeFirst,
                      //                           'options': {
                      //                             rightAnswerController.text
                      //                                 .toString()
                      //                                 .capitalize: true,
                      //                             falseAnswerController1.text
                      //                                 .toString()
                      //                                 .capitalize: false,
                      //                             falseAnswerController2.text
                      //                                 .toString()
                      //                                 .capitalize: false,
                      //                             falseAnswerController3.text
                      //                                 .toString()
                      //                                 .capitalize: false
                      //                           }
                      //                         }
                      //                       }
                      //                     });
                      //                     // ref.child(_categoryNameController.text
                      //                     //     .toString());
                      //                     Get.back();
                      //                   },
                      //                   child: const Text('Done'))
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     });
                    },
                    label: const Text('Add New Category')),
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:
                      // db.newCategorys.isEmpty
                      //     ? CircularProgressIndicator()
                      //     :
                      GridView.builder(
                          itemCount: db.newCategorys.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.toNamed(quiz,
                                    arguments: Quizdata(
                                        db.newCategorys[index].toString()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                    child: Text(
                                  db.newCategorys[index].toString(),
                                  style: const TextStyle(fontSize: 25),
                                )),
                              ),
                            );
                          }),
                ),
              );
            }
          }
          return const Center(
            child: Text('No Data'),
          );
        });
  }
}

class AddNewQuizCategoryScreen extends StatefulWidget {
  const AddNewQuizCategoryScreen({super.key});

  @override
  State<AddNewQuizCategoryScreen> createState() =>
      _AddNewQuizCategoryScreenState();
}

class _AddNewQuizCategoryScreenState extends State<AddNewQuizCategoryScreen> {
  final TextEditingController _categoryNameController = TextEditingController();
  final questionController = TextEditingController();
  final rightAnswerController = TextEditingController();
  final falseAnswerController1 = TextEditingController();
  final falseAnswerController2 = TextEditingController();
  final falseAnswerController3 = TextEditingController();
  DatabaseReference ref = FirebaseDatabase.instance.ref("taste");
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black)),
              title: const Text(
                'Add New Category',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText("Category Name"),
                      customFormField(
                          TextInputType.text,
                          _categoryNameController,
                          context,
                          'category name', (val) {
                        if (val == null || val.isEmpty) {
                          return "this field can't be empty";
                        }
                        return null;
                      }),
                      CustomText("Question"),
                      customFormField(TextInputType.text, questionController,
                          context, 'Add Question', (val) {
                        if (val == null || val.isEmpty) {
                          return "this field can't be empty";
                        }
                        return null;
                      }),
                      // Center(child: CustomText("Options")),
                      CustomText("Right Answer"),
                      customFormField(TextInputType.text, rightAnswerController,
                          context, 'Right Answer', (val) {
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
                      SizedBox(
                        width: 300,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                try {
                                  ref.update({
                                    _categoryNameController.text.toString(): {
                                      questionController.text
                                          .toString()
                                          .capitalizeFirst!: {
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
                                      }
                                    }
                                  }).then((value) {
                                    Get.snackbar('Congratulations',
                                        "New Category Added Successfully");
                                    setState(() {
                                      loading = false;
                                    });
                                  }).onError((error, stackTrace) {
                                    Get.snackbar('Error', error.toString());
                                    setState(() {
                                      loading = false;
                                    });
                                  });
                                } catch (e) {
                                  Get.snackbar("Error", e.toString());
                                }
                              } else {
                                Get.snackbar(
                                    'Warning', 'Please Fillup All Input field');
                              }

                              // ref.child(_categoryNameController.text
                              //     .toString());
                              Get.back();
                            },
                            child: const Text(
                              'Add',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
