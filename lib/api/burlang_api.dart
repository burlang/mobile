import 'dart:convert';

import 'package:burlang_demo/models/buryat_name.dart';
import 'package:burlang_demo/models/buryat_names.dart';
import 'package:burlang_demo/models/buryat_translation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BurlangApi {
  Future<BuryatName> getName(String name) async {
    final response = await http.get(
      Uri.parse("http://burlang.ru/api/v1/names/get-name?q=$name"),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return BuryatName.fromJson(jsonDecode(response.body));
    } else {
      debugPrint(response.body);
    }
    return null;
  }

  Future<List<BuryatNames>> getAllNames(String letter, String query) async {
    final response = await http.get(
      Uri.parse('http://burlang.ru/api/v1/names'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final List jsonResponse = jsonDecode(response.body);
      final sortedList = jsonResponse
          .where((element) => element['value'][0] == letter)
          .toList();
      return sortedList
          .map((val) => BuryatNames.fromJson(val))
          .where((buryatName) {
        final nameLower = buryatName.name.toLowerCase();
        final searchLower = query.toLowerCase();

        return nameLower.contains(searchLower);
      }).toList();
    } else {
      debugPrint(response.body);
    }
    return null;
  }

  Future<Translations> getBuryatTranslation(String value) async {
    final response = await http.get(
      Uri.parse('http://burlang.ru/api/v1/buryat-word/translate?q=$value'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final body = response.body;

    if (response.statusCode == 200) {
      return Translations.fromJson(jsonDecode(response.body));
    } else {
      debugPrint(response.body);
    }
    return null;
  }
}
