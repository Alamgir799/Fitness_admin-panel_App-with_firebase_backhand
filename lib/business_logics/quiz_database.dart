
import 'dart:convert';

import 'package:http/http.dart' as http;

class DBconnect {
  // let's first create  a function to add a question to our database.
// declare the name of the table you want to create and add .json as suffix
// String? categoryName;
//questions.json
  // final url = Uri.parse(
  //     'https://fitness-mobile-app-de0be-default-rtdb.asia-southeast1.firebasedatabase.app/');

  //for category list
  List newCategorys = [];
  Future<List> fetchCategoryList() async {
    return http
        .get(Uri.parse(
            'https://fitness-mobile-app-de0be-default-rtdb.asia-southeast1.firebasedatabase.app/taste.json'))
        .then((response) {
      var data = json.decode(response.body);
      newCategorys.clear();
      data.forEach((key, value) {
        newCategorys.add(key);
      });

      //print(newCategorys);
      //print(newCategorys.length);
      return newCategorys;
    });
  }


}