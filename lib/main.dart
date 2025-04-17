import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyMotorcycles());

class MyMotorcycles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Favorite Vehicles',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> vehicles = [];
  final String _apiURL = "https://67f945e0094de2fe6ea109f1.mockapi.io/api/v1/Vehicle";
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchVehicles();
  }

  Future<void>fetchVehicles() async {
    final response = await http.get(Uri.parse(_apiURL), headers: {'Content-Type': 'application/json; charset=utf8'});
    
    if(response.statusCode == HttpStatus.ok) {
      setState(() {
        String data = utf8.decode(response.bodyBytes);
        vehicles = json.decode(data);
      });
    }else {
      showDialog(context: context, builder: (BuildContext context) => AlertDialog(
        title: const Text('Atenção'),
        content: const Text('Erro ao carregar dados da aplicação!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Ok')
          , child: const Text('Ok')
          )
        ],
      ));
    }
  }
  
  Future<void>saveVehicle() async {

    if(_brandController.text.trim().isEmpty || _typeController.text.trim().isEmpty || _modelController.text.trim().isEmpty || _nameController.text.trim().isEmpty) {
      return showDialog(context: context, builder: (BuildContext context) => AlertDialog(
        title: const Text('Atenção'),
        content: const Text('Favor informar todos os dados para salvar!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Ok')
          , child: const Text('Ok')
          )
        ],
      ));
    }

    final response = await http.post(
      Uri.parse(_apiURL),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
          'brand': _brandController.text.trim(),
          'type': _typeController.text.trim(),
          'model': _modelController.text.trim(),
          'name': _nameController.text.trim()
        })
    );
    
    if(response.statusCode == HttpStatus.created) {
      setState(() {
        String data = utf8.decode(response.bodyBytes);
        vehicles.add(jsonDecode(data));
      });

      showDialog(context: context, builder: (BuildContext context) => AlertDialog(
        title: const Text('Sucesso'),
        content: const Text("Sucesso ao salvar informações sobre o veículo! Favor Consultar a lista abaixo !"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Ok')
          , child: const Text('Ok')
          )
        ],
      ));
    }else {
      showDialog(context: context, builder: (BuildContext context) => AlertDialog(
        title: const Text('Atenção'),
        content: const Text('Erro ao salvar informarção na aplicação!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Ok')
          , child: const Text('Ok')
          )
        ],
      ));
    }
  }

  void resetFields() {
    _brandController.text = "";
    _typeController.text = "";
    _modelController.text = "";
    _nameController.text = "";
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favorite Vehicles <3")
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _brandController,
                    decoration: InputDecoration(
                      labelText: 'Digite o nome da marca'
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _typeController,
                    decoration: InputDecoration(
                      labelText: 'Digite o tipo do veículo (Ex.: Moto, Van, Carro, SUV)'
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _modelController,
                    decoration: InputDecoration(
                      labelText: 'Digite o modelo do veículo'
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Digite o nome do veículo',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            resetFields();
                          },
                          child: Text("Resetar")
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            saveVehicle();
                          },
                          child: Text("Enviar")
                        ),
                      )
                    ],
                  )
                  
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 500.0,
                child: ListView.separated(
                  itemCount: vehicles.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("Marca: ${vehicles[index]['brand']} - Tipo: ${vehicles[index]['type']} - Modelo: ${vehicles[index]['model']} - Nome: ${vehicles[index]['name']}"),
                    );
                  },
                ),
              )
            )
            
          ],
        ),
      ),
    );
  }
}
