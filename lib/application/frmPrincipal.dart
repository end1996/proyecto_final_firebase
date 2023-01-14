import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final_firebase/application/frmSegTipoUsuarios.dart';
import 'package:proyecto_final_firebase/infrastructure/controllers/conexion.dart';
import 'package:proyecto_final_firebase/infrastructure/controllers/datos.dart';
import '../infrastructure/controllers/images_data.dart';
import '../infrastructure/entitymanager/theme.dart';
import 'Prueba.dart';
import 'frmSegLogin.dart';
import 'package:firebase_storage/firebase_storage.dart';

class frmPrincipal extends StatefulWidget {
  @override
  State<frmPrincipal> createState() => _frmPrincipal();
}

class _frmPrincipal extends State<frmPrincipal> {
  int _counter = 1;
  int _counter2 = 1;
  int _counter3 = 1;
  int _counter4 = 1;
  int _counter5 = 1;
  int _counter6 = 1;

  void _incrementCounter() {
    if (_counter < 3) {
      setState(() {
        print('El botón ha sido presionado:$_counter');
        _counter++;
      });
    }
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        print('El botón ha sido presionado:$_counter');
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Variedades Heucar App'),
          actions: [
            Icon(
              Icons.shopping_cart_checkout,
              size: 40,
              color: Colors.green,
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 100,
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Variedades Heucar',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              Container(
                child: TextField(
                  controller: txtBuscar,
                  decoration: InputDecoration(
                      labelText: 'Buscar producto',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: const Text(
                  'Inicio',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                shape: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  'Menú principal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => frmPrincipal(),
                      ));
                },
              ),
              Container(
                height: 50,
                color: Colors.blue,
                padding: EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Text(
                      'Categorías',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 70.0),
                shape: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  'Ferretería',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 70.0),
                shape: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  'Útiles escolares',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 70.0),
                shape: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                  ),
                  top: BorderSide(
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  'Papelería',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              AboutListTile(
                icon: Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                child: Text(
                  'Acerca del app',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                applicationIcon: Icon(
                  Icons.local_play,
                ),
                applicationName: 'Variedades Heucar App',
                applicationVersion: '1.0.25',
                applicationLegalese: '© 2023 Company',
                aboutBoxChildren: [
                  Text(
                      'Esta app fue desarrollada por Enmanuel Nava. Todos los derechos reservados')
                ],
              ),
            ],
          ),
        ),
        body: FutureBuilder(
          future: _ListadoImagenes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return snapshot.data;
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Future<Widget> _ListadoImagenes() async {
    List<Widget> Lista = [];
    List<Widget> ListaProductos = [];
    var PR = await Productos.get();
    var IMG = await getImageName();
    for (int i = 0; i < IMG.length; i++) {
      var patchName = await getImagePath(IMG[i]);
      ImageAlgo items = ImageAlgo(
        imagePatch: patchName,
      );
      Lista.add(items);
      var Mapa = await getProduct();
      var nombre = Mapa[i]["nombre"];
      var detalles = Mapa[i]["detalles"];
      Lista.add(
        Column(
          children: [
            Text(nombre),
            Text(detalles),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: _decrementCounter,
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            Text('Cantidad: $_counter'),
            ElevatedButton.icon(
                label: Text("Agregar al carrito"),
                icon: Icon(Icons.shopping_cart),
                onPressed: (() {}))
          ],
        ),
      );
    }
    return GridView.extent(
      maxCrossAxisExtent: 200.0,
      padding: const EdgeInsets.all(10.0),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 5.0,
      children: (Lista),
    );
  }
}

FirebaseFirestore db = FirebaseFirestore.instance;
CollectionReference Productos = db.collection('productos');
