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
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => {
          query = ''
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => {
        close(context, null)
      },
      icon: Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    // TODO: adicionar variável state
    final state = context.watch<AnimeState>();
    state.searchAnime(query);

    // TODO: res = state.animeSearchJson
    final res = state.animeSearchJson;

    final loading = state.loadingSearch;

    if (loading) return Center(child: CircularProgressIndicator());

    // talvez isso seja desnecessário
    // final total = Provider.of<Anime>(context, listen: false).totalResults;

    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        if(!res.asMap().containsKey(index)){
          return ListTile(
            title: Text(" ")
          );
        }
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
    for (var anime in searchTerms){
      if (anime.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(anime);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index){
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () => {query = result},
        );
      },
    );
  }

}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context){
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
              showSearch(
                context: context,
                delegate: CustomSearchDelegate()
              )
            },
          ),
        ],
      ),
    );
  }
}