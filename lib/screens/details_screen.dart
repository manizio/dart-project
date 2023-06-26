import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anime_provider.dart';


class AnimeInfoWidget extends StatelessWidget {

  final animeJson;

  AnimeInfoWidget({required this.animeJson});
  
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.network(
          animeJson['images']['jpg']['large_image_url'],
          fit: BoxFit.cover,
          height: 200,
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            animeJson['title'],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            animeJson['synopsis'],
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
    );
    
  }
}



class AnimeDetailScreen  extends StatelessWidget {
  AnimeDetailScreen ({Key? key}) : super (key:key);
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AnimeState>();
    final res = state.anime;

    final loading = state.loadingAnime;
    if (loading) return Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Anime'),
      ),
      body: Center(child: Column(
        children:<Widget>[
          AnimeInfoWidget(animeJson: res,),
        ],
      ),
      )
      
    );
  }
}
