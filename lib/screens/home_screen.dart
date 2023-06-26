import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anime_provider.dart';
import 'nav_drawer.dart';

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;

  DataTableWidget({this.jsonObjects = const [], this.columnNames = const ["Título", "Tipo", "Episódios"], this.propertyNames = const ["title", "type", "episodes"]});

  @override
  Widget build(BuildContext context){
    return DataTable(
              columns: columnNames.map(
                (nome) => DataColumn(
                  label: Expanded(
                    child: Text(nome),
                  )
                )
              ).toList(),
              rows: jsonObjects.map(
                (obj) => DataRow(
                  cells: propertyNames.map((e) => DataCell(
                    Text("${obj[e]}"),
                    onTap: () {
                      context.read<AnimeState>().loadAnime(obj['mal_id']);
                      Navigator.pushNamed(context, '/detail');
                    },
                  ),).toList()
                )
              ).toList()
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
        child: SingleChildScrollView(
          child: Column(
            children: [DataTableWidget(jsonObjects: res)]
          ),
        )
      ),
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