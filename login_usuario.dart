import 'package:flutter/material.dart';

class LoginUsuario extends StatelessWidget {
  const LoginUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_police.jpg'), // fundo (coloque uma imagem em assets)
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        child: Center(
          child: Container(
            width: 320,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.blueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person, color: Colors.white, size: 60),
                SizedBox(height: 10),
                Text(
                  'Acesso Usuário',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Portal Cidadão',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    hintText: 'Digite seu Usuário',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    hintText: 'Digite sua senha',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {},
                  child: Text('Entrar'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login_policial');
                  },
                  child: Text('Acesso Policial'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

































//import 'package:flutter/material.dart';
//class LoginPage extends StatelessWidget {
//  const LoginPage({super.key});
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Stack(
//        children: [
//          Container(
//            decoration: const BoxDecoration(
//              image: DecorationImage(
//                image: AssetImage(''), 
//                fit: BoxFit.cover,
//                opacity: 0.3, 
//              ),
//            ),
//          ),
//
//    
//          Center(
//            child: Container(
//              width: 320,
//              padding: const EdgeInsets.all(20),
//              decoration: BoxDecoration(
//                color: const Color(0xFF0057FF), // azul principal
//                borderRadius: BorderRadius.circular(20),
//                boxShadow: [
//                  BoxShadow(
//                    color: Colors.black.withOpacity(0.3),
//                    blurRadius: 10,
//                    offset: const Offset(2, 4),
//                  ),
//                ],
//              ),
//              child: Column(
//                mainAxisSize: MainAxisSize.min,
//                children: [
//                  const Icon(
//                    Icons.person,
//                    size: 70,
//                    color: Colors.white,
//                  ),
//                  const SizedBox(height: 10),
//                  const Text(
//                    'Acesso Usuário',
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 22,
//                      fontWeight: FontWeight.bold,
//                    ),
//                  ),
//                  const Text(
//                    'Portal Cidadão',
//                    style: TextStyle(
//                      color: Colors.white70,
//                      fontSize: 16,
//                    ),
//                  ),
//                  const SizedBox(height: 25),
//
//                  
//                  TextField(
//                    decoration: InputDecoration(
//                      labelText: 'Usuário',
//                      hintText: 'Digite seu Usuário',
//                      hintStyle: const TextStyle(color: Colors.white70),
//                      labelStyle: const TextStyle(color: Colors.white),
//                      filled: true,
//                      fillColor: Colors.white.withOpacity(0.2),
//                      border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(10),
//                        borderSide: BorderSide.none,
//                      ),
//                    ),
//                    style: const TextStyle(color: Colors.white),
//                  ),
//                  const SizedBox(height: 15),
//
//                  
//                  TextField(
//                    obscureText: true,
//                    decoration: InputDecoration(
//                      labelText: 'Senha',
//                      hintText: 'Digite sua senha',
//                      hintStyle: const TextStyle(color: Colors.white70),
//                      labelStyle: const TextStyle(color: Colors.white),
//                      filled: true,
//                      fillColor: Colors.white.withOpacity(0.2),
//                      border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(10),
//                        borderSide: BorderSide.none,
//                      ),
//                    ),
//                    style: const TextStyle(color: Colors.white),
//                  ),
//                  const SizedBox(height: 25),
//
//                  
//                  SizedBox(
//                    width: double.infinity,
//                    height: 45,
//                    child: ElevatedButton(
//                      onPressed: () {},
//                      style: ElevatedButton.styleFrom(
//                        backgroundColor: Colors.amber,
//                        foregroundColor: Colors.black,
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(10),
//                        ),
//                      ),
//                      child: const Text(
//                        'Entrar',
//                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                      ),
//                    ),
//                  ),
//                  const SizedBox(height: 10),
//
//                  
//                  SizedBox(
//                    width: double.infinity,
//                    height: 45,
//                    child: OutlinedButton(
//                      onPressed: () {},
//                      style: OutlinedButton.styleFrom(
//                        side: const BorderSide(color: Colors.white),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(10),
//                        ),
//                      ),
//                      child: const Text(
//                        'Voltar',
//                        style: TextStyle(color: Colors.white, fontSize: 18),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
