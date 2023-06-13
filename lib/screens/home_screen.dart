import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anime_provider.dart';

class MyHomePage extends StatelessWidget{
  MyHomePage ({Key? key}) : super (key:key);

  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("${context.watch<Anime>().animesJson}"),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            key: Key('load_floatingActionButton'),
            onPressed: () => context.read<Anime>().loadAnimes(),
            tooltip: 'Load',
            child: Icon(Icons.play_arrow)
          )
        ],
      ),
    );
  }
}