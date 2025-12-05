import 'package:flutter/material.dart';
import 'citizen_login_screen.dart';
import 'police_login_screen.dart';
import 'register_screen.dart';

class UserSelectionScreen extends StatelessWidget {
  const UserSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4DD0E1), Color(0xFF26C6DA)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D47A1),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5))],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Icon(Icons.shield, size: 60, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('SIGOR', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  const SizedBox(height: 8),
                  const Text('Sistema Integrado de Gestão de Ocorrência', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(height: 50),
                  const Text('Selecione o tipo de usuário', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 30),
                  
                  _buildUserCard(context, icon: Icons.person, title: 'Usuário', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CitizenLoginScreen()))),
                  const SizedBox(height: 20),
                  _buildUserCard(context, icon: Icons.shield, title: 'Polícia Militar', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PoliceLoginScreen()))),
                  const SizedBox(height: 30),
                  
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen())),
                    child: const Text('Não tem cadastro? Cadastre-se aqui', style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.underline)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0D47A1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Container(width: 80, height: 80, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: Icon(icon, size: 50, color: const Color(0xFF0D47A1))),
                const SizedBox(height: 16),
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.arrow_forward, size: 16), SizedBox(width: 8), Text('Entrar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
