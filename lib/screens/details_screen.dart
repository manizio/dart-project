import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anime_provider.dart';


class AnimeInfoWidget extends StatelessWidget {
  final animeJson;

  AnimeInfoWidget({required this.animeJson});
  
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AnimeState>(context);
    final description = animeJson['synopsis'];
    final shortenedDescription = description.substring(0, 100);


    return Center(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child:
          Image.network(
            animeJson['images']['jpg']['large_image_url'],
            fit: BoxFit.cover,
            height: 200,
          ),
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
            state.showFullDescription ? description : shortenedDescription,
            style: TextStyle(fontSize: 16),
          ),
        ),
        if (description.length > 100)
          TextButton(
            onPressed: () {
              state.toggleDescription();
            },
            child: Text(
              state.showFullDescription ? 'Mostrar Menos' : 'Mostrar Mais',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
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
      body: Center(
        child : SingleChildScrollView(
          child: Column(
            children:<Widget>[
              AnimeInfoWidget(animeJson: res,),
            ],
          ),
        )
      )
      
    );
  }
}
