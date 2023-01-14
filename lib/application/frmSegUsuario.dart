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
      home: userRegister(),
    );
  }
}

// ignore: camel_case_types, use_key_in_widget_constructors
class userRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Registrarse"),
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
                        hintText: 'Usuario',
                        labelText: 'Ingrese su usuario',
                        prefixIcon: Icon(Icons.person),
                        ),
                        
                    controller: user,
                  ), 
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: 270,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        hintText: 'Contraseña',
                        labelText: 'Ingrese su contraseña',
                        prefixIcon: Icon(Icons.lock),
                        ),
                        
                    controller: pass,
                  ), 
                  ),
                 Container(
                  padding: EdgeInsets.all(10.0),
                    width: 270,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        hintText: 'Confirmar contraseña',
                        labelText: 'Confirme su contraseña',
                        prefixIcon: Icon(Icons.password),
                        ),
                        
                    controller: rePass,
                  ), 
                  ),
                  ElevatedButton(
                    child: Text('Enviar'),
                    onPressed: () {
                      FirebaseFirestore.instance.collection('usuarios').add({
                        'codigo': "USU00004",
                        'cod_tipo': "TU00002",
                        'login': user.text,
                        if(pass.text == rePass.text)'clave': pass.text,
                      });
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Registro realizado con éxito'),
                            );
                          });
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => HomePage(),
                          //   ));
                    },
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
