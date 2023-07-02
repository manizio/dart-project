import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anime_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'nav_drawer.dart';

class DataTableWidget extends HookWidget {
  final List jsonObjects;
  DataTableWidget({this.jsonObjects = const [],});

  @override
  Widget build(BuildContext context){
    var controller = useScrollController();
    useEffect(
      (){
        controller.addListener(
          (){
            if(controller.position.pixels == controller.position.maxScrollExtent){
              context.read<AnimeState>().loadMoreData();
            }
          }
        );
      }, [controller]
    );
    
    return GridView.count(
      //primary: false,
      //padding: const EdgeInsets.all(20),
      controller: controller,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: jsonObjects.map(
        (obj) => Center(child: InkWell(
          onTap: (){
            context.read<AnimeState>().loadAnime(obj['mal_id']);
            Navigator.pushNamed(context,'/detail');  
          },
          child:
            Card( 
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Container(
                decoration:BoxDecoration(
                  image:
                    DecorationImage(
                      image:
                        NetworkImage(
                          obj['images']['jpg']['large_image_url'],
                        ),
                        fit: BoxFit.fill,
                  ),
                ) 
              ),
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 7),
              
            )
        )
        )).toList()
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
