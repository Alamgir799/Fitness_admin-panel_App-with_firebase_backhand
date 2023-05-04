import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class addData {
  adminDataAdd(type, title, description, category, thumbnailUrl, images, time,
      comments, rating, likes) async {
    try {
      await FirebaseFirestore.instance
          .collection("items")
          .doc(type)
          .collection("all")
          .doc()
          .set({
        'type': type,
        'title': title,
        'description': description,
        'category': category,
        'thumbnail': thumbnailUrl,
        if (type == 'blog') 'blog_images': images,
        if (type == 'podcast') 'url': images,
        if (type == 'video') 'url': images,
        'time_stamp': time,
        'comments': comments,
        'rating': rating,
        'total_likes': likes
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}


// PlatformFile? pickedFile;
//   String? url;

//   Future selectFile() async {
//     final box = GetStorage();
//     DateTime now = DateTime.now();
//     final result = await FilePicker.platform
//         .pickFiles(type: FileType.any, allowMultiple: false);

//     if (result != null && result.files.isNotEmpty) {
//       final ref = await FirebaseStorage.instance
//           .ref('users-profile-images')
//           .child(now.toString());
//       final pickedFile = result.files.first.bytes;
//       UploadTask uploadTask = ref.putData(pickedFile!);

//       final snapshot = await uploadTask.whenComplete(() {});
//       final urlDownload = await snapshot.ref.getDownloadURL();

//       setState(() {
//         url = urlDownload;
//       });
//     //  await box.write('profileImg', urlDownload);
//     }
//   }