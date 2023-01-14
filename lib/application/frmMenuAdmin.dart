import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final_firebase/application/frmManCategorias.dart';
import 'package:proyecto_final_firebase/application/frmManCliente.dart';
import 'package:proyecto_final_firebase/application/frmManUsuario.dart';
import 'package:proyecto_final_firebase/application/frmManDistrito.dart';
import 'package:proyecto_final_firebase/application/frmManMetodoPago.dart';
import 'package:proyecto_final_firebase/application/frmManProductos.dart';

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
      home: menuAdmin(),
    );
  }
}

class menuAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú de administrador'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildListDelegate([
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddUsers(),
                            ));
                      }),
                      child: Text('Mantenimiento de usuarios')),
                      ElevatedButton(
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddData(),
                            ));
                      }),
                      child: Text('Mantenimiento de productos')),
                      ElevatedButton(
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddCategories(),
                            ));
                      }),
                      child: Text('Mantenimiento de Categorías')),
                      ElevatedButton(
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddZone(),
                            ));
                      }),
                      child: Text('Mantenimiento de Distritos')),
                      ElevatedButton(
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPaymentMethod(),
                            ));
                      }),
                      child: Text('Mantenimiento de Métodos de pago')),
                      ElevatedButton(
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddClients(),
                            ));
                      }),
                      child: Text('Mantenimiento de clientes')),
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
