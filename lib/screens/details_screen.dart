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
          Column(
            children: [
              Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: SizedBox(
                  width: 336,
                  height: 480,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          animeJson['images']['jpg']['large_image_url'],
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ), 
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 7),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: ListTile(
                        title: Text("Episódios: ${animeJson['episodes']}"),
                        subtitle:Text("${animeJson['status']}"),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite, color: Colors.pink),
                            Text("${animeJson['favorites']}")
                          ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Image.network(
          //   animeJson['images']['jpg']['large_image_url'],
          //   fit: BoxFit.cover,
          //   height: 200,
          // ),
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
