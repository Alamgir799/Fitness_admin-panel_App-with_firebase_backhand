import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_admin_project/ui/route/route.dart';
import 'package:fitness_admin_project/ui/views/category.dart';
import 'package:fitness_admin_project/ui/views/quiz_data.dart';
import 'package:fitness_admin_project/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../business_logics/add_data.dart';
import '../widgets/custome_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController _blogImagesController1 = TextEditingController();
  TextEditingController _blogImagesController2 = TextEditingController();
  TextEditingController _blogImagesController3 = TextEditingController();
  TextEditingController _blogImagesController4 = TextEditingController();
  TextEditingController _blogImagesController5 = TextEditingController();
  TextEditingController _blogImagesController6 = TextEditingController();
  TextEditingController _blogImagesController7 = TextEditingController();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _thumbnailController = TextEditingController();
  TextEditingController _videoSorceController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  RxString category = 'video'.obs;
  RxInt allValue = 0.obs;

  // Initial Selected Value
  String dropdownvalue = 'video';

  // List of items in our dropdown menu
  var items = [
    'blog',
    'podcast',
    'video',
  ];
  String? selectedProduct;
  List listOfProduct = [];
  int number = 0;
  final _formKey = GlobalKey<FormState>();
  bool loadingForThumbnail = false;
  bool loadingForSourceurl = false;
  bool loadingForBlogImages = false;
  bool loadingForButton = false;
  //for thumbnail url

  PlatformFile? pickedFileForThumbnail;

  Future selectFileForThumbnail() async {
    try {
      setState(() {
        loadingForThumbnail = true;
      });
      DateTime now = DateTime.now();
      final result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: false);

      if (result != null && result.files.isNotEmpty) {
        final ref = FirebaseStorage.instance
            .ref('items')
            .child(dropdownvalue)
            .child(now.toString());
        final pickedFileForThumbnail = result.files.first.bytes;
        UploadTask uploadTask = ref.putData(pickedFileForThumbnail!);

        final snapshot = await uploadTask.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();

        setState(() {
          _thumbnailController.text = urlDownload;
          loadingForThumbnail = false;
        });
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  //for podcast/video url

  PlatformFile? pickedFileForSourceUrl;

  Future selectFileForSourceUrl() async {
    try {
      setState(() {
        loadingForSourceurl = true;
      });
      DateTime now = DateTime.now();
      final result = await FilePicker.platform.pickFiles(
          type: dropdownvalue == 'video' ? FileType.video : FileType.audio,
          allowMultiple: false);

      if (result != null && result.files.isNotEmpty) {
        final ref = FirebaseStorage.instance
            .ref('items')
            .child(dropdownvalue)
            .child(now.toString());
        final pickedFileForSourceUrl = result.files.first.bytes;
        UploadTask uploadTask = ref.putData(pickedFileForSourceUrl!);

        final snapshot = await uploadTask.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();

        setState(() {
          _videoSorceController.text = urlDownload;
          loadingForSourceurl = false;
        });
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  //for blog images

  PlatformFile? pickedFileForBlogImages;

  Future selectFileForBlogImages(controller) async {
    try {
      // setState(() {
      //   loading = true;
      // });
      DateTime now = DateTime.now();
      final result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: false);

      if (result != null && result.files.isNotEmpty) {
        final ref = FirebaseStorage.instance
            .ref('items')
            .child('blog')
            .child(now.toString());
        final pickedFileForBlogImages = result.files.first.bytes;
        UploadTask uploadTask = ref.putData(pickedFileForBlogImages!);

        final snapshot = await uploadTask.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();

        setState(() {
          controller.text = urlDownload;
          // loading = false;
        });
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    List controllers = [
      _blogImagesController3,
      _blogImagesController4,
      _blogImagesController5,
      _blogImagesController6,
      _blogImagesController7
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFDADADA),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.2,
          width: MediaQuery.of(context).size.width / 2,
          color: const Color(0xFFFCFCFC),
          child: SingleChildScrollView(
            // scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "Add New Item",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    CustomText("Type"),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.amber),
                      ),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: DropdownButton(
                        value: dropdownvalue,
                        underline: const SizedBox(),
                        isExpanded: true,
                        hint: const Text('Select Type'),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                            // print(dropdownvalue);
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText("Title"),
                    customFormField(
                        TextInputType.text, _titleController, context, "Title",
                        (value) {
                      if (value == null || value.isEmpty) {
                        return "this field can't be empty";
                      } else if (value.length < 3) {
                        return "user name must be more than 3 character.";
                      }

                      return null;
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText("Description"),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      controller: _descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "this field can't be empty";
                        } else if (value.length < 3) {
                          return "user name must be more than 3 character.";
                        }

                        return null;
                      },
                      minLines: 3,
                      maxLines: 6,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(15, 15, 20, 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.amber),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                        hintText: "Description",
                        hintStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText("Category"),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.amber)),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('items')
                              .doc(dropdownvalue)
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            listOfProduct.clear();
                            for (int i = 0;
                                i < snapshot.data['categories'].length;
                                i++) {
                              var snap = snapshot.data['categories'][i];
                              listOfProduct.add(snap['category_name']);
                            }

                            return DropdownButtonFormField(
                              value: selectedProduct,
                              // underline: const SizedBox(),
                              isExpanded: true,
                              decoration: const InputDecoration(
                                  hintText: 'Select Type',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                              // hint: const Text('Select Type'),

                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: listOfProduct.map((items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedProduct = newValue as String;
                                  // print(selectedProduct);
                                });
                              },
                            );
                          }),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(categoryScreen,
                            arguments: CategoryItemScreen(dropdownvalue));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) =>
                        //             CategoryItemScreen(dropdownvalue)));
                      },
                      child: const Text("Add New Category"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText("Thumbnail url"),
                    Row(
                      children: [
                        Expanded(
                          child: loadingForThumbnail
                              ? const Center(child: CircularProgressIndicator())
                              : customFormField(
                                  TextInputType.text,
                                  _thumbnailController,
                                  context,
                                  "thumbnail url", (value) {
                                  if (value == null || value.isEmpty) {
                                    return "this field can't be empty";
                                  }

                                  return null;
                                }),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: IconButton(
                              onPressed: selectFileForThumbnail,
                              icon: const Icon(Icons.add_circle)),
                        )
                      ],
                    ),
                    (dropdownvalue == 'blog')
                        ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText("Blog images"),
                                Row(
                                  children: [
                                    Expanded(
                                      child: customFormField(
                                          TextInputType.text,
                                          _blogImagesController1,
                                          context,
                                          "blog image url 1", (value) {
                                        if (value == null || value.isEmpty) {
                                          return "this field can't be empty";
                                        }

                                        return null;
                                      }),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: IconButton(
                                          onPressed: () =>
                                              selectFileForBlogImages(
                                                  _blogImagesController1),
                                          icon: const Icon(Icons.add_circle)),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: customFormField(
                                          TextInputType.text,
                                          _blogImagesController2,
                                          context,
                                          "blog image url 2", (value) {
                                        if (value == null || value.isEmpty) {
                                          return "this field can't be empty";
                                        }

                                        return null;
                                      }),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: IconButton(
                                          onPressed: () =>
                                              selectFileForBlogImages(
                                                  _blogImagesController2),
                                          icon: const Icon(Icons.add_circle)),
                                    )
                                  ],
                                ),
                                number == 0
                                    ? const SizedBox()
                                    : SizedBox(
                                        height: number * 60,
                                        child: ListView.builder(
                                            itemCount: number,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3.1,
                                                    child: customFormField(
                                                        TextInputType.text,
                                                        controllers[index],
                                                        context,
                                                        "blog image url ${index + 3}",
                                                        (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "this field can't be empty";
                                                      }

                                                      return null;
                                                    }),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        number--;
                                                        setState(() {});
                                                      },
                                                      icon: const Icon(
                                                          Icons.remove)),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10.0),
                                                    child: IconButton(
                                                        onPressed: () =>
                                                            selectFileForBlogImages(
                                                                controllers[
                                                                    number -
                                                                        1]),
                                                        icon: const Icon(
                                                            Icons.add_circle)),
                                                  )
                                                ],
                                              );
                                            }),
                                      ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        number++;
                                      });
                                    },
                                    icon: const Icon(Icons.add))
                              ],
                            ),
                          )
                        : (dropdownvalue == 'podcast')
                            ? Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText("Podcast url"),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: loadingForSourceurl
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : customFormField(
                                                  TextInputType.text,
                                                  _videoSorceController,
                                                  context,
                                                  "podcast url", (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "this field can't be empty";
                                                  }

                                                  return null;
                                                }),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: IconButton(
                                              onPressed: selectFileForSourceUrl,
                                              icon:
                                                  const Icon(Icons.add_circle)),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText("Video source link"),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: loadingForSourceurl
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : customFormField(
                                                  TextInputType.text,
                                                  _videoSorceController,
                                                  context,
                                                  "Video source link", (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "this field can't be empty";
                                                  }

                                                  return null;
                                                }),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: IconButton(
                                              onPressed: selectFileForSourceUrl,
                                              icon:
                                                  const Icon(Icons.add_circle)),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              try {
                                setState(() {
                                  loadingForButton = true;
                                });
                                addData().adminDataAdd(
                                    dropdownvalue,
                                    _titleController.text.toString(),
                                    _descriptionController.text.toString(),
                                    selectedProduct,
                                    _thumbnailController.text.toString(),
                                    dropdownvalue == 'blog'
                                        ? number == 5
                                            ? [
                                                _blogImagesController1.text,
                                                _blogImagesController2.text,
                                                _blogImagesController3.text,
                                                _blogImagesController4.text,
                                                _blogImagesController5.text,
                                                _blogImagesController6.text,
                                                _blogImagesController7.text
                                              ]
                                            : number == 4
                                                ? [
                                                    _blogImagesController1.text,
                                                    _blogImagesController2.text,
                                                    _blogImagesController3.text,
                                                    _blogImagesController4.text,
                                                    _blogImagesController5.text,
                                                    _blogImagesController6.text,
                                                  ]
                                                : number == 3
                                                    ? [
                                                        _blogImagesController1
                                                            .text,
                                                        _blogImagesController2
                                                            .text,
                                                        _blogImagesController3
                                                            .text,
                                                        _blogImagesController4
                                                            .text,
                                                        _blogImagesController5
                                                            .text,
                                                      ]
                                                    : number == 2
                                                        ? [
                                                            _blogImagesController1
                                                                .text,
                                                            _blogImagesController2
                                                                .text,
                                                            _blogImagesController3
                                                                .text,
                                                            _blogImagesController4
                                                                .text,
                                                          ]
                                                        : number == 1
                                                            ? [
                                                                _blogImagesController1
                                                                    .text,
                                                                _blogImagesController2
                                                                    .text,
                                                                _blogImagesController3
                                                                    .text,
                                                              ]
                                                            : [
                                                                _blogImagesController1
                                                                    .text,
                                                                _blogImagesController2
                                                                    .text,
                                                              ]
                                        : _videoSorceController.text,
                                    DateTime.now(),
                                    [],
                                    {},
                                    []).then((value) {
                                  setState(() {
                                    loadingForButton = false;
                                  });
                                  Get.snackbar('Congratulations',
                                      "New Questions Added Successfully");
                                });
                                number = 0;
                                _titleController.clear();
                                _descriptionController.clear();
                                _thumbnailController.clear();
                                _blogImagesController1.clear();
                                _blogImagesController2.clear();
                                _blogImagesController3.clear();
                                _blogImagesController4.clear();
                                _blogImagesController5.clear();
                                _blogImagesController6.clear();
                                _blogImagesController7.clear();
                                _videoSorceController.clear();
                              } catch (e) {
                                Get.snackbar('Error', e.toString());
                              }
                            } else {
                              Get.snackbar(
                                  'Warning', 'Please Fillup All Input field');
                            }
                          },
                          child: loadingForButton
                              ? const Center(child: CircularProgressIndicator())
                              : const Text("Submit"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
