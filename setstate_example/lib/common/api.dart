import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class Api {
  static const String BASE_URL = 'https://gorest.co.in/public/v1/';
  static const String USER = BASE_URL + 'users';

  static Future<List<User>?> users(int page) async {
    final url = '$USER?page=$page';
    final res = await http.get(Uri.parse(url));

    print(url);

    if (res.statusCode == 200) {
      final json = await compute(jsonDecode, res.body);

      if (json is Map && json.containsKey('data')) {
        final data = json['data'];

        if (data is List) {
          return data.map<User>((u) => User.fromJson(u)).toList();
        }
      }
    }

    return null;
  }
}