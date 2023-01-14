import 'dart:math';

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
      home: AddData(),
    );
  }
}

class AddData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Mantenimiento de productos"),
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
                        
                    controller: codP,
                  ), 
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: 270,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        hintText: 'Detalles',
                        labelText: 'Ingrese el detalle',
                        prefixIcon: Icon(Icons.description),
                        ),
                    controller: descP,
                  ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: 270,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        hintText: 'Estado',
                        labelText: 'Ingrese el estado',
                        prefixIcon: Icon(Icons.app_settings_alt),
                        ),
                    controller: estadoP,
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
                        prefixIcon: Icon(Icons.production_quantity_limits),
                        ),
                    controller: nomP,
                  ),
                  ),
                 Container(
                    padding: EdgeInsets.all(10.0),
                    width: 270,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        hintText: 'Precio',
                        labelText: 'Ingrese el precio',
                        prefixIcon: Icon(Icons.price_change),
                        ),
                    controller: precioVentaP,
                  ),
                  ),
                  //Falta modificar y eliminar
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: 270,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        hintText: 'Stock',
                        labelText: 'Ingrese el stock',
                        prefixIcon: Icon(Icons.library_books),
                        ),
                    controller: stockP,
                  ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text('Insertar'),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('productos')
                              .doc(codP.text)
                              .set({
                            'codigo': codP.text,
                            'detalles': descP.text,
                            'estado': estadoP.text,
                            'nombre': nomP.text,
                            'precio_venta': precioVentaP.text,
                            'stock': stockP.text
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
                                .collection('productos')
                                .doc(codP.text)
                                .update({
                              'detalles': descP.text,
                            'estado': estadoP.text,
                            'nombre': nomP.text,
                            'precio_venta': precioVentaP.text,
                            'stock': stockP.text
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
                              .collection('productos')
                              .doc(codP.text)
                              .delete();
                              showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                            'Se ha eliminado exitosamente'),
                                      );
                                    });
                              // .then((productos) => AlertDialog (title: Text('Se ha eliminado correctamente'),));
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
