import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_data.dart';
import 'admin_panel_screen.dart';
import 'forgot_password_screen.dart';

class PoliceLoginScreen extends StatefulWidget {
  const PoliceLoginScreen({Key? key}) : super(key: key);

  @override
  State<PoliceLoginScreen> createState() => _PoliceLoginScreenState();
}

class _PoliceLoginScreenState extends State<PoliceLoginScreen> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  
  String _usuarioError = '';
  String _senhaError = '';
  bool _showSenha = false;

  @override
  void dispose() {
    _usuarioController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    setState(() {
      _usuarioError = '';
      _senhaError = '';
    });

    bool hasError = false;

    if (_usuarioController.text.isEmpty) {
      setState(() => _usuarioError = 'Você precisa digitar sua matrícula');
      hasError = true;
    }

    if (_senhaController.text.isEmpty) {
      setState(() => _senhaError = 'Você precisa digitar sua senha');
      hasError = true;
    }

    if (!hasError) {
      AppData.policeMatricula = _usuarioController.text;
      AppData.userName = 'Sgt. Silva';
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminPanelScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.grey[300]),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Container(
                decoration: BoxDecoration(color: const Color(0xFF0066CC), borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 80, height: 80, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.shield, size: 50, color: Color(0xFF0066CC))),
                    const SizedBox(height: 20),
                    const Text('Polícia Militar', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('Sistema Corporativo', style: TextStyle(color: Colors.white, fontSize: 18)),
                    const SizedBox(height: 32),
                    
                    _buildTextField(controller: _usuarioController, label: 'Usuário', hint: 'Digite sua matrícula', error: _usuarioError, inputFormatters: [FilteringTextInputFormatter.digitsOnly], keyboardType: TextInputType.number),
                    if (_usuarioError.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 4), child: Text(_usuarioError, style: const TextStyle(color: Colors.red, fontSize: 14))),
                    const Padding(padding: EdgeInsets.only(top: 4), child: Text('Digite apenas números', style: TextStyle(color: Colors.white70, fontSize: 13))),
                    const SizedBox(height: 20),
                    
                    _buildTextField(controller: _senhaController, label: 'Senha', hint: 'Digite sua senha', error: _senhaError, obscureText: !_showSenha, maxLength: 8, suffixIcon: IconButton(icon: Icon(_showSenha ? Icons.visibility : Icons.visibility_off, color: Colors.grey), onPressed: () => setState(() => _showSenha = !_showSenha))),
                    if (_senhaError.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 4), child: Text(_senhaError, style: const TextStyle(color: Colors.red, fontSize: 14))),
                    const SizedBox(height: 12),
                    
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen(isPolice: true))),
                        child: const Text('Esqueceu a senha?', style: TextStyle(color: Colors.white, fontSize: 14, decoration: TextDecoration.underline)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: _handleLogin, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0), child: const Text('Entrar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)))),
                    const SizedBox(height: 12),
                    SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0), child: const Text('Voltar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)))),
                    const SizedBox(height: 16),
                    const Text('Sistema restrito aos membros da Polícia Militar', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String error,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    int? maxLength,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            counterText: '',
            suffixIcon: suffixIcon,
          ),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
