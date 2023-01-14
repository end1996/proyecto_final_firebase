import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final_firebase/application/frmMenuAdmin.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import '../infrastructure/controllers/cLogin.dart';
import '../infrastructure/controllers/datos.dart';
import '../infrastructure/entitymanager/theme.dart';
import 'frmErrorDeDatos.dart';
import 'frmManProductos.dart';
import 'frmSegUsuario.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
}


class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text('Proyecto final'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildListDelegate([
              //Columna principal

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                      height: 200,
                      width: 200,
                    ),
                    padding: EdgeInsets.all(15.0),
                  ),

                  //Columna de imagen con login
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 300,
                        child: TextField(
                          controller: username,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                            hintText: 'Usuario',
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.5),
                            ),
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: TextField(
                          controller: password,
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                            ),
                            hintText: 'Contraseña',
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.5),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //columna de boton login
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(2.5),
                        child: Container(
                          width: 200,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              shadowColor: Colors.purpleAccent,
                              elevation: 10,
                            ),
                            onPressed: () {
                              validarDatos(context);
                              
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => menuAdmin())); 
                              print('Ingresando...');
                            },
                            child: Text(
                              'Iniciar sesión',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(1.25),
                        child: Container(
                          width: 200,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              shadowColor: Colors.purpleAccent,
                              elevation: 10,
                            ),
                            onPressed: () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => userRegister(),
                            ));
                            },
                            child: Text(
                              'Registrarse',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shadowColor: Colors.purpleAccent,
                          elevation: 10,
                        ),
                        onPressed: () => theme.setTheme(ThemeData.light()),
                        child: Icon(
                          Icons.light_mode_sharp,
                          color: Colors.amber,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shadowColor: Colors.purpleAccent,
                          elevation: 10,
                        ),
                        onPressed: () => theme.setTheme(ThemeData.dark()),
                        child: Icon(Icons.dark_mode_sharp),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 500,
              // mainAxisSpacing: 1000,
              mainAxisExtent: 650,
            ),
          ),
        ],
      ),
    );
  }
}
