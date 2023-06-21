import 'package:flutter/material.dart';

class AnimeInfoWidget extends StatelessWidget {
  final String title;
  final String description;
  AnimeInfoWidget({required this.title, required this.description});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Image.network(),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            description,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}


class AnimeDetailScreen  extends StatelessWidget {
  AnimeDetailScreen ({Key? key}) : super (key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Anime'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget>[
          AnimeInfoWidget(
            title: "Naruto",
            description: "anime triste",
          ),
        ],
      ),
    );
  }
}
