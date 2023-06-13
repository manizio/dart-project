import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Anime with ChangeNotifier{
  var _animesJson;

  get animesJson => _animesJson;

  void loadAnimes() async {
    var animeUri = Uri(
      scheme: 'https',
      host: 'api.jikan.moe',
      path: 'v4/anime',
      queryParameters: {'q': 'naruto'},
    );

    var jsonString = await http.read(animeUri);
    _animesJson = jsonDecode(jsonString);
    notifyListeners();
  }
}