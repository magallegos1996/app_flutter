import 'package:flutter/material.dart'; //usar material design
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
        home: HomePage()
    ),
  );
}
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState()=> _HomePageState();
}
class _HomePageState extends State<HomePage>{

  Map datos;
  List usuarios;

  @override
  void initState(){
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        backgroundColor: Colors.indigo[900],
      ),
      body: ListView.builder(
        itemCount: usuarios == null ? 0 : usuarios.length,
        itemBuilder: (BuildContext context, int i) {
          return Card(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("$i",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(usuarios[i]['avatar']),
                  ),
                  Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Text("${usuarios[i]["nombre"]} ${usuarios[i]["apellido"]}"),
                  )
                ],
              )
          );
        },
      ),
    );
  }

  getUsers() async{
    http.Response response = await http.get('http://10.0.2.2:4000/api/users');
    //debugPrint(response.body);
    datos = json.decode(response.body); //se convierte a formato json
    setState(() {
      usuarios = datos['users']; //Esta usando la propiedad users, del json
    });
  }

}