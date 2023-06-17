import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class NavDrawer extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(fontSize: 25),
            ),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Pesquisar'),
            onTap: () => {
              Navigator.pushNamed(context, '/search'),         
            }
          ),
          ListTile(
            leading: Icon(Icons.arrow_upward_sharp),
            title: Text('Melhores Animes'),
            onTap: () => {
              Navigator.pushNamed(context, '/best'),
            },
          ),
        
        ],
      ),
    );
  }
}