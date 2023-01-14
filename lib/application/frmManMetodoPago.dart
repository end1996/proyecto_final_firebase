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
      home: AddPaymentMethod(),
    );
  }
}

class AddPaymentMethod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Mantenimiento de métodos de pago"),
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
                        
                    controller: codMMP,
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
                        prefixIcon: Icon(Icons.payment),
                        ),
                    controller: nomMMP,
                  ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: Text('Insertar'),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('metodo_pago')
                              .doc(codMMP.text)
                              .set({
                            'codigo': codMMP.text,
                            'nombre': nomMMP.text,
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
                                .collection('metodo_pago')
                                .doc(codMMP.text)
                                .update({
                              'nombre': nomMMP.text,
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
                              .collection('metodo_pago')
                              .doc(codMMP.text)
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