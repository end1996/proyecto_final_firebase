// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto_final_firebase/application/Prueba.dart';
import 'package:firebase_core/firebase_core.dart';

Future<List> getProduct() async {
  List Product = [];
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference Productos = db.collection('productos');

  QuerySnapshot queryProduct = await Productos.get();

  queryProduct.docs.forEach((documento) {
    Product.add(documento.data());
  });
  Future.delayed(const Duration(seconds: 5));
  return Product;
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<List<String>> getImagePath() async {
    var ListaImagenes = await FirebaseStorage.instance.ref().listAll();
    List<String> Imagenes = [];
    for (int i = 0; i < ListaImagenes.items.length; i++) {
      Imagenes.add(ListaImagenes.items[i].fullPath);
    }
    return Imagenes;
  }
}

Future<List<String>> getImageName() async {
  FirebaseStorage ds = FirebaseStorage.instance;
  var ListaImagenes = await ds.ref('/images').listAll();
  List<String> Imagenes = [];
  for (int i = 0; i < ListaImagenes.items.length; i++) {
    Imagenes.add(ListaImagenes.items[i].fullPath);
  }
  return Imagenes;
}

Future<String> getImagePath(String imageName) async {
  FirebaseStorage ds = FirebaseStorage.instance;
  var ListaImagenes = await ds.ref(imageName).getDownloadURL();
  return ListaImagenes;
}
