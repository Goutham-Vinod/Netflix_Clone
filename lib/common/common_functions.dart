import 'dart:convert';

import '../model/model_class.dart';
import 'package:http/http.dart' as http;

import 'common_variables.dart';

String truncateWithEllipsis(int cutoff, String myString) {
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)}...';
}

// loadData(String path) async {
//   ModelClass? obj;

//   final response = await http.get(Uri.parse(path));
//   if (response.statusCode == 200) {
//     Map<String, dynamic> results = json.decode(response.body);
//     obj = ModelClass.fromJson(results);
//   }
//   randomObj = obj;
//   return obj;
// }


