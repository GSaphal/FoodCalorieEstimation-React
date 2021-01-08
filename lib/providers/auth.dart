import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import '../utils/api.dart';
import '../utils/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  var MainUrl = Api.api;

  String _token;
  String _userId;
  String _userEmail;
  String _userName;
  String _userAge;
  String _userHeight;
  String _userWeight;
  DateTime _expiryDate;
  Timer _authTimer;
  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
  }

  String get userId {
    return _userId;
  }

  String get userEmail {
    return _userEmail;
  }

  Future<void> logout() async {
    _token = null;
    _userEmail = null;
    _userId = null;
    _userName = null;
    _userAge = null;
    _userHeight = null;
    _userId = null;
    _expiryDate = null;

    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    notifyListeners();

    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  Future<bool> tryautoLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(pref.getString('userData')) as Map<String, Object>;

    _token = extractedUserData['token'];

    notifyListeners();

    return true;
  }

  Future<void> Authentication(String email, String password) async {
    try {
      final url = '${MainUrl}login';

      final response =
          await http.post(url, body: {'email': email, 'password': password});
      final responseData = json.decode(response.body);
      print(responseData['success']);
      if (responseData['success'] != "true") {
        throw HttpException('INVALID_CREDENTAILS');
      }
      _token = responseData['access_token'];
      _userId = responseData['id'].toString();
      _userEmail = responseData['email'];
      _userName = responseData['name'];
      _userAge = responseData['age'];
      _userWeight = responseData['weight'];
      _userHeight = responseData['height'];

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'name': _userName,
        'email': _userEmail,
        'age': _userAge,
        'weight': _userWeight,
        'height': _userHeight,
        'id': _userId,
      });
      prefs.setString('userData', userData);
      print('check' + userData.toString());
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUp(String email, String password, String name, String age,
      String height, String weight) async {
    try {
      final url = '${MainUrl}register';

      final response = await http.post(url, body: {
        'email': email,
        'password': password,
        'height': height,
        'weight': weight,
        'age': age,
        'name': name
      });
      print(response);

      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['success'] != "true") {
        throw HttpException('INVALID_CREDENTAILS');
      }

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> login(String email, String password) {
    return Authentication(email, password);
  }

  Future<void> register(String email, String password, String name, String age,
      String height, String weight) {
    return signUp(email, password, name, age, height, weight);
  }
}
