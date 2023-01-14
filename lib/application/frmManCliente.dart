import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../infrastructure/controllers/datos.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then(
    (value) => runApp(
      MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      home: AddClients(),
    );
  }
}

class AddClients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Mantenimiento de clientes"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildListDelegate([
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: 270,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        hintText: 'Código',
                        labelText: 'Ingrese el código',
                        prefixIcon: Icon(Icons.code),
                        ),
                        
                    controller: codMC,
                  ), 
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: 270,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        hintText: 'Código de usuario',
                        labelText: 'Código de usuario',
                        prefixIcon: Icon(Icons.code),
                        ),
                    controller: codMUC,
                  ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: 270,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        hintText: 'Distrito',
                        labelText: 'Código de distrito',
                        prefixIcon: Icon(Icons.code),
                        ),
                    controller: codMDC,
                  ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: 270,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        hintText: 'Nombre',
                        labelText: 'Ingrese el nombre',
                        prefixIcon: Icon(Icons.person),
                        ),
                    controller: nomMC,
                  ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: 270,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        hintText: 'Apelllidos',
                        labelText: 'Ingrese los apellidos',
                        prefixIcon: Icon(Icons.person_rounded),
                        ),
                    controller: apellMC,
                  ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: 270,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        hintText: 'Documento',
                        labelText: 'Ingrese DNI o CE',
                        prefixIcon: Icon(Icons.article_outlined),
                        ),
                    controller: docMC,
                  ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: Text('Insertar'),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('clientes')
                              .doc(codMC.text)
                              .set({
                            'codigo': codMC.text,
                            'cod_usuario': codMUC.text,
                            'cod_distrito': codMDC.text,
                            'nombres': nomMC.text,
                            'apellidos': apellMC.text,
                            'dni_ce': docMC.text,
                          });
                          showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                            'Se ha registrado exitosamente'),
                                      );
                                    });
                        },
                      ),
                      ElevatedButton(
                          onPressed: (() {
                            FirebaseFirestore.instance
                                .collection('clientes')
                                .doc(codMC.text)
                                .update({
                            'nombres': nomMC.text,
                            'apellidos': apellMC.text,
                            'dni_ce': docMC.text,
                            });
                            showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                            'Se han modificado algunos datos'),
                                      );
                                    });
                          }),
                          child: Text('Modificar')),
                      
                      ElevatedButton(
                          onPressed: (() {
                            FirebaseFirestore.instance
                              .collection('clientes')
                              .doc(codMC.text)
                              .delete();
                              showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                            'Se ha eliminado exitosamente'),
                                      );
                                    });
                          }), child: Text('Eliminar')),
                    ],
                  ),
                  
                ],
              )
            ]),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 500,
              // mainAxisSpacing: 1000,
              mainAxisExtent: 650,
            ),
          )
        ],
      ),
    );
  }
}