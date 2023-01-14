import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../infrastructure/controllers/conexion.dart';
import 'frmSegTipoUsuarios.dart';
  
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
  
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      home: ListaProductos(),
    );
  }
}
  
class ListaProductos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Lista"),
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

        )
    );
  }
Future<Widget> _ListadoImagenes() async {
    List<Widget> Lista = [];

    var IMG = await getImageName();
    for (int i = 0; i < IMG.length; i++) {
      var patchName = await getImagePath(IMG[i]);
      ImageAlgo items = ImageAlgo(imagePatch: patchName,);
      Lista.add(items);

    }
    Column columna = Column(children: Lista);
    return columna;
  }
}

class ImageAlgo extends StatelessWidget {
  String imagePatch;
    ImageAlgo({
    Key? key,

    this.imagePatch = "",
  }) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      
      return Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(imagePatch),fit: BoxFit.cover)
        ),
      );
    }
  } 

  // class ProductoAlgo extends StatelessWidget {
  // String ProductName;
  //   ProductoAlgo({
  //   Key? key,

  //   this.ProductName = "",
  // }) : super(key: key);
  
  //   @override
  //   Widget build(BuildContext context) {
      
  //     return Container(
  //       width: 200,
  //       height: 200,
  //       child: Text(ProductName),
  //     );
  //   }
  // } 

 //  body: FutureBuilder(
        //       future: Productos.get(),
        //       builder: (BuildContext context, AsyncSnapshot snapshot) {
        //         if (snapshot.hasData) {
        //           return ListView.builder(

        //             itemCount: snapshot.data.docs.length,
        //             itemBuilder: (context, index) {
        //               return Text("${snapshot.data.docs[index].data()['nombre']}${snapshot.data.docs[index].data()['detalles']}");
                      
        //             },
        //           );
        //         } else {
        //           return Center(
        //             child: CircularProgressIndicator(),
        //           );
        //         }
        //       },
        //     )

          // floatingActionButton: FloatingActionButton(
        //     child: Text('data'),
        //     onPressed: (() async {
        //       List imageFirebase = [];
        //       var IMG = await getImageName();
        //       for (int i = 0; i < IMG.length; i++) {
        //         var patchName = await getImagePath(IMG[i]);
        //         imageFirebase.add(patchName);
        //       }
        //       print(imageFirebase[1]);
        //     }))

           
    // Column columna = Column(children: Lista);
    // return columna;
    // return _ListadoImagenes();

    
  // List<Widget> get _imagesList {
  //   List<Widget> _listImages = [];

  //   for (var image in images) {
  //     _listImages.add(
  //       Image.network(image, fit: BoxFit.cover),
  //     );

  //     _listImages.add(
  //       Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               FloatingActionButton(
  //                 onPressed: _decrementCounter,
  //                 tooltip: 'Decrement',
  //                 child: const Icon(Icons.remove),
  //               ),
  //               FloatingActionButton(
  //                 onPressed: _incrementCounter,
  //                 tooltip: 'Increment',
  //                 child: const Icon(Icons.add),
  //               ),
  //             ],
  //           ),
  //           Text('Cantidad: $_counter'),
  //           ElevatedButton.icon(
  //               label: Text("Agregar al carrito"),
  //               icon: Icon(Icons.shopping_cart),
  //               onPressed: (() {}))
  //         ],
  //       ),
  //     );
  //     // _listImages.add(
    //     FutureBuilder(
    //     future: getProduct(),
    //     builder: ((context, snapshot) {
    //       if (snapshot.hasData) {

    //         return ListView.builder(
    //           itemCount: snapshot.data?.length,
    //           itemBuilder: (context, index) {
    //             return Text(snapshot.data?[index]['nombre']);
    //           },
    //         );
    //       } else {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     }),
    //   ),
    //   );
    // }

  //   return _listImages;
  // }

   Future<Widget> _WidgetImagenStorage(String imageName) async {
    Widget Prueba = Image.network(imageName);
    return Prueba;
  }