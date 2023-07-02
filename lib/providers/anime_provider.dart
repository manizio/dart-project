import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AnimeState with ChangeNotifier{
  bool _showFullDescription = false;
  bool get showFullDescription => _showFullDescription;
  void toggleDescription() {
    _showFullDescription = !_showFullDescription;
    notifyListeners();
  }

  var _topAnimesJson = [];
  var _animeJson;
  
  var _animeSearchJson = [];
  var _totalResults;

  var _requestPage = 2;
  get requestPage => _requestPage;
  
  get topAnimesJson => _topAnimesJson;
  get anime => _animeJson;
  get animeSearchJson => _animeSearchJson;
  get totalResults => _totalResults;

  bool _loadingBestAnimes = false;
  get loadingBestAnimes => _loadingBestAnimes;

  bool _loadingMoreData = false;
  get loadingMoreData => _loadingMoreData;
  

  bool _loadingSearch = false;
  get loadingSearch => _loadingSearch;

  bool _loadingAnime = false;
  get loadingAnime => _loadingAnime;

  void loadBestAnimes() async {
    _loadingBestAnimes = true;
    notifyListeners();
    var animeUri = Uri(
      scheme: 'https',
      host: 'api.jikan.moe',
      path: 'v4/top/anime',
    );

    var jsonString = await http.read(animeUri);
    var data = jsonDecode(jsonString);
    _topAnimesJson = data["data"];
    _loadingBestAnimes = false;
    notifyListeners();
  }

  void loadMoreData() async {
    _loadingMoreData = true;
    notifyListeners();

    var animeUri = Uri (
      scheme: 'https',
      host: 'api.jikan.moe',
      path: 'v4/top/anime',
      queryParameters: {'page': '${_requestPage}'}
    );

    var jsonString = await http.read(animeUri);
    var data = jsonDecode(jsonString);
    var newData = data["data"];

    _topAnimesJson.addAll(newData);
    _loadingMoreData = false;
    _requestPage += 1;
    notifyListeners();

  }

  void loadAnime(mal_id) async {
    _loadingAnime = true;
    notifyListeners();

    var animeUri = Uri(
      scheme: 'https',
      host: 'api.jikan.moe',
      path: "v4/anime/${mal_id}"
    );

    var jsonString = await http.read(animeUri);
    var data = jsonDecode(jsonString);
    _animeJson = data["data"];
    _loadingAnime = false;
    notifyListeners();
  }

  void searchAnime(string) async {
    // TODO: adicionar variável de load para checar se a requisição foi concluida
    _loadingSearch = true;
    notifyListeners();

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
    _loadingSearch = false;
    notifyListeners();
  }
}