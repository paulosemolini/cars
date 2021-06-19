import 'package:carros/api/carros_api.dart';
import 'package:carros/model/carro.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatelessWidget {
  const CarrosListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    Future<List<Carros>> future = CarrosApi.getCarros();
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<Carros>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Não foi possível buscar os dados.',
              style: TextStyle(
                color: Colors.red,
                fontSize: 25,
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carros>? carros = snapshot.data;
        return _listView(carros!);
      },
    );
  }

  Container _listView(List<Carros> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros.length,
        itemBuilder: (context, index) {
          Carros c = carros[index];
          return Card(
            color: Colors.grey[200],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      c.urlFoto,
                      // ??
                      // 'https://grvalle.files.wordpress.com/2011/12/erro.jpg?w=640',
                      width: 150,
                    ),
                  ),
                  Text(
                    c.nome,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'descrição...',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  ButtonTheme(
                    child: ButtonBar(
                      children: [
                        TextButton(
                            onPressed: () {}, child: const Text('DETALHES')),
                        TextButton(
                            onPressed: () {}, child: const Text('SHARE')),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
