import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final_firebase/application/frmErrorDeDatos.dart';
import 'package:proyecto_final_firebase/infrastructure/controllers/datos.dart';
// import 'package:proyecto_final_firebase/aplication/frmSegLogin.dart';
import '../../application/frmMenuAdmin.dart';
import '../../application/frmPrincipal.dart';

validarDatos(BuildContext context) async {
  
  try {
    CollectionReference ref = FirebaseFirestore.instance.collection('usuarios');
    QuerySnapshot usuario = await ref.get();
    
    if(usuario.docs.length != 0) {
      for(var documentID in usuario.docs) {
        if(documentID.get('login') == username.text) {
          print('Usuario Encontrado');
          print(documentID.get('codigo'));
          if(documentID.get('clave')==password.text){
            print('********* Acceso aceptado *****');
            print('El usuario  es de tipo --> '+documentID.get('cod_tipo'));
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => frmPrincipal()));   
          }
        }
      }
    }else {
      print('No hay documentos en la colección');
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => errorDeDatos()));   
      
    }
  }
  catch(e){
    print('Error...'+e.toString());
  }
}

