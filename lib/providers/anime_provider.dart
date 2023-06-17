import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Anime with ChangeNotifier{
  var _topAnimesJson = [];
  var _animeJson = [];
  
  var _animeSearchJson = [];
  var _totalResults;


  get topAnimesJson => _topAnimesJson;
  get anime => _animeJson;
  get animeSearchJson => _animeSearchJson;
  get totalResults => _totalResults;

  void loadBestAnimes() async {
    var animeUri = Uri(
      scheme: 'https',
      host: 'api.jikan.moe',
      path: 'v4/top/anime',
    );

    var jsonString = await http.read(animeUri);
    var data = jsonDecode(jsonString);
    _topAnimesJson = data["data"];
    notifyListeners();
  }

  void loadAnime(mal_id) async {
    var animeUri = Uri(
      scheme: 'https',
      host: 'api.jikan.moe',
      path: "v4/anime/${mal_id}"
    );

    var jsonString = await http.read(animeUri);
    var data = jsonDecode(jsonString);
    _animeJson = data;
    notifyListeners();
  }

  void searchAnime(string) async {
    var animeUri = Uri(
      scheme: 'https',
      host: 'api.jikan.moe',
      path: 'v4/anime',
      queryParameters: {'q': "${string}", 'limit': '20'},
    );

    var jsonString = await http.read(animeUri);
    var data = jsonDecode(jsonString);
    _animeSearchJson = data["data"];
    _totalResults = data["pagination"]["items"]["total"];
    notifyListeners();
  }
}