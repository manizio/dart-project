import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'nav_drawer.dart';
import '../providers/anime_provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  var searchTerms = [
    'Naruto',
    'Dragon Ball Z',
    'One Piece',
    'Shingeki no Kyojin'
  ];

  bool hasPressedEnter = false; // Flag para rastrear se o usuário pressionou Enter

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => {
          query = '',
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => {
              close(context, null),
            },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final state = context.watch<AnimeState>();

    if (hasPressedEnter) {
      state.searchAnime(query);
      hasPressedEnter = false; // Redefine a flag após realizar a pesquisa
    }

    final res = state.animeSearchJson;
    final loading = state.loadingSearch;

    if (loading) return Center(child: CircularProgressIndicator());

    return ListView.builder(
      itemCount: res.length,
      itemBuilder: (context, index) {
        var result = res[index]['title'];
        return ListTile(
          title: Text(result),
          onTap: () => {print(res[index]['mal_id'])},
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var anime in searchTerms) {
      if (anime.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(anime);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () => {query = result},
        );
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    hasPressedEnter = true; // Define a flag como verdadeiro quando o usuário pressionar Enter
    super.showResults(context);
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<AnimeState>().loadBestAnimes();
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Pesquisar"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Pesquisar',
            onPressed: () => {
              showSearch(context: context, delegate: CustomSearchDelegate())
            },
          ),
        ],
      ),
    );
  }
}
