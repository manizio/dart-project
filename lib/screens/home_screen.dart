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
                    onTap: () => {print(obj['mal_id'])},
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
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [DataTableWidget(jsonObjects: context.watch<Anime>().topAnimesJson)]
          ),
        )
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            key: Key('load_floatingActionButton'),
            onPressed: () => context.read<Anime>().loadBestAnimes(),
            tooltip: 'Load',
            child: Icon(Icons.play_arrow)
          )
        ],
      ),
    );
  }
}