import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import '../utils/api.dart';
import '../utils/http_exception.dart';
import 'package:http/http.dart' as http;

class Calorie with ChangeNotifier {
  var MainUrl = Api.api;
  Future<void> calorie(String calorie, String userId) async {
    try {
      final url = '${MainUrl}calorie/create';
      final response =
          await http.post(url, body: {calorie: calorie, userId: userId});

      final responseData = json.decode(response.body);
      print(responseData['success']);
      if (responseData['success'] != "true") {
        throw HttpException('INVALID_CREDENTAILS');
      }

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> getCalorie(String calorieData, String userId) {
    return calorie(calorieData, userId);
  }
}
