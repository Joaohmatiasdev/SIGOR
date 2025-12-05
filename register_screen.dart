import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/formatters.dart';
import 'citizen_login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController = TextEditingController();
  
  String _nomeError = '';
  String _cpfError = '';
  String _emailError = '';
  String _senhaError = '';
  String _confirmaSenhaError = '';
  bool _showSenha = false;
  bool _showConfirmaSenha = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _confirmaSenhaController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _handleRegister() {
    setState(() {
      _nomeError = '';
      _cpfError = '';
      _emailError = '';
      _senhaError = '';
      _confirmaSenhaError = '';
    });

    bool hasError = false;

    if (_nomeController.text.isEmpty) {
      setState(() => _nomeError = 'Você precisa digitar seu nome');
      hasError = true;
    } else if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(_nomeController.text)) {
      setState(() => _nomeError = 'Digite apenas letras no nome');
      hasError = true;
    }

    if (_cpfController.text.isEmpty) {
      setState(() => _cpfError = 'Você precisa digitar seu CPF');
      hasError = true;
    }

    if (_emailController.text.isEmpty) {
      setState(() => _emailError = 'Você precisa digitar seu email');
      hasError = true;
    } else if (!_isValidEmail(_emailController.text)) {
      setState(() => _emailError = 'Digite um email válido');
      hasError = true;
    }

    if (_senhaController.text.isEmpty) {
      setState(() => _senhaError = 'Você precisa digitar sua senha');
      hasError = true;
    } else if (_senhaController.text.length < 6) {
      setState(() => _senhaError = 'A senha deve ter no mínimo 6 caracteres');
      hasError = true;
    }

    if (_confirmaSenhaController.text.isEmpty) {
      setState(() => _confirmaSenhaError = 'Você precisa confirmar sua senha');
      hasError = true;
    } else if (_senhaController.text != _confirmaSenhaController.text) {
      setState(() => _confirmaSenhaError = 'As senhas não coincidem');
      hasError = true;
    }

    if (!hasError) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cadastro realizado com sucesso!')));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CitizenLoginScreen()));
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
                    Container(width: 80, height: 80, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.person_add, size: 50, color: Color(0xFF0066CC))),
                    const SizedBox(height: 20),
                    const Text('Cadastro de Usuário', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('Portal Cidadão', style: TextStyle(color: Colors.white, fontSize: 18)),
                    const SizedBox(height: 32),
                    
                    _buildTextField(controller: _nomeController, label: 'Nome Completo', hint: 'Digite seu nome completo', error: _nomeError, inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ÿ\s]'))]),
                    if (_nomeError.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 4), child: Text(_nomeError, style: const TextStyle(color: Colors.red, fontSize: 14))),
                    const Padding(padding: EdgeInsets.only(top: 4), child: Text('Digite apenas letras', style: TextStyle(color: Colors.white70, fontSize: 13))),
                    const SizedBox(height: 20),
                    
                    _buildTextField(controller: _cpfController, label: 'CPF', hint: '000.000.000-00', error: _cpfError, inputFormatters: [CpfInputFormatter()], keyboardType: TextInputType.number),
                    if (_cpfError.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 4), child: Text(_cpfError, style: const TextStyle(color: Colors.red, fontSize: 14))),
                    const SizedBox(height: 20),
                    
                    _buildTextField(controller: _emailController, label: 'Email', hint: 'exemplo@email.com', error: _emailError, keyboardType: TextInputType.emailAddress),
                    if (_emailError.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 4), child: Text(_emailError, style: const TextStyle(color: Colors.red, fontSize: 14))),
                    const SizedBox(height: 20),
                    
                    _buildTextField(controller: _senhaController, label: 'Senha', hint: 'Digite sua senha (min. 6 caracteres)', error: _senhaError, obscureText: !_showSenha, maxLength: 8, suffixIcon: IconButton(icon: Icon(_showSenha ? Icons.visibility : Icons.visibility_off, color: Colors.grey), onPressed: () => setState(() => _showSenha = !_showSenha))),
                    if (_senhaError.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 4), child: Text(_senhaError, style: const TextStyle(color: Colors.red, fontSize: 14))),
                    const SizedBox(height: 20),
                    
                    _buildTextField(controller: _confirmaSenhaController, label: 'Confirmar Senha', hint: 'Digite sua senha novamente', error: _confirmaSenhaError, obscureText: !_showConfirmaSenha, maxLength: 8, suffixIcon: IconButton(icon: Icon(_showConfirmaSenha ? Icons.visibility : Icons.visibility_off, color: Colors.grey), onPressed: () => setState(() => _showConfirmaSenha = !_showConfirmaSenha))),
                    if (_confirmaSenhaError.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 4), child: Text(_confirmaSenhaError, style: const TextStyle(color: Colors.red, fontSize: 14))),
                    const SizedBox(height: 32),
                    
                    SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: _handleRegister, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0), child: const Text('Cadastrar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)))),
                    const SizedBox(height: 12),
                    SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0), child: const Text('Voltar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)))),
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
