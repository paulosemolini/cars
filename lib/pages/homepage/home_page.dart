import 'package:carros/commons/drawer_list.dart';
import 'package:carros/pages/homepage/carros_listview.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Carros - Login WebService'),
      ),
      body: CarrosListView(),
      drawer: DrawerList(),
    );
  }
}
