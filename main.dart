import 'package:flutter/material.dart';
import 'login_usuario.dart';
import 'login_policial.dart';


void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portal de Acesso',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login_usuario',
      routes: {
        '/login_usuario': (context) => LoginUsuario(),
        '/login_policial': (context) => LoginPolicial(),
      },
    );
  }
}









