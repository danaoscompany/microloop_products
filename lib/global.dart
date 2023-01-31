import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Global {

  static void show(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static Future navigate(context, screen) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static Future navigateAndClear(context, screen) async {
    return await Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => screen,
      ), (route) => false
    );
  }

  static void replaceScreen(context, screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static getWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static getHeight(context) {
    return MediaQuery.of(context).size.width;
  }

  static httpGet(url) async {
    var response = await http.get(Uri.parse(url));
    return response;
  }

  static httpPost(url, headers, params) async {
    var response = await http.post(Uri.parse(url), headers: headers, body: params);
    return response;
  }

  static generateRandomNumber(length) {
    var multiplier = 1;
    if (length > 1) {
      for (var i = 0; i < length-1; i++) {
        multiplier *= 10;
      }
    }
    var rng = new Random();
    var code = rng.nextInt(9*multiplier)+multiplier;
    return code;
  }

  static generateRandomString(int length) {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static String formatCategory(category) {
    var categorySplits = category.split("-");
    var fullCategory = "";
    for (var i=0; i<categorySplits.length; i++) {
      var split = categorySplits[i];
      fullCategory += (split.substring(0, 1).toUpperCase())+(split.substring(1, split.length).toLowerCase());
      fullCategory += " ";
    }
    return fullCategory.trim();
  }

  static String formatMoney(amount) {
    final formatter = new NumberFormat("#,##0.00", "en_US");
    return formatter.format(amount);
  }
}
