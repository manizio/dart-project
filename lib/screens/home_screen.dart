import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anime_provider.dart';
import 'nav_drawer.dart';

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;
  DataTableWidget({this.jsonObjects = const [],});

  @override
  Widget build(BuildContext context){
    print(jsonObjects);
    return GridView.count(
      //primary: false,
      //padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: jsonObjects.map(
        (obj) => Center(child: Text(obj["title"]))).toList()
        );
  }
}

class MyHomePage extends StatelessWidget{
  MyHomePage ({Key? key}) : super (key:key);
  final List<String> propertyNames = ["title", "type", "episodes"];

  @override
  Widget build(BuildContext context){

    // carregar o estado da aplicação na variável state
    final state = context.watch<AnimeState>();
    final res = state.topAnimesJson;

    // checar se a requisição foi concluída
    final loading = state.loadingBestAnimes;
    if (loading) return Center(child: CircularProgressIndicator());
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: Center(
        child: DataTableWidget(jsonObjects: res)
      ),
      //bottomNavigationBar: LoadingWidget(showLoading: state.loadingMoreData),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            key: Key('load_floatingActionButton'),
            onPressed: () => context.read<AnimeState>().loadBestAnimes(),
            tooltip: 'Load',
            child: Icon(Icons.play_arrow)
          )
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget{
  final bool showLoading;
  LoadingWidget({this.showLoading=true});
  @override
  Widget build(BuildContext context){
    return showLoading ? Center(child: Text("loading")): Center(child: Text("mamae eu to na globo"));
  }
}