import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/formatters.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final bool isPolice;
  const ForgotPasswordScreen({Key? key, this.isPolice = false}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int _currentStep = 0;
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  String _recoveryMethod = 'email';

  @override
  void dispose() {
    _cpfController.dispose();
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleNextStep() {
    if (_currentStep == 0) {
      if (widget.isPolice && _cpfController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Digite sua matrícula')));
        return;
      } else if (!widget.isPolice && _cpfController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Digite seu CPF')));
        return;
      }
      
      if (_recoveryMethod == 'email' && _emailController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Digite seu e-mail')));
        return;
      }
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Código enviado para ${_recoveryMethod == 'email' ? 'seu e-mail' : 'seu telefone'}')));
      setState(() => _currentStep = 1);
    } else if (_currentStep == 1) {
      if (_codeController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Digite o código recebido')));
        return;
      }
      setState(() => _currentStep = 2);
    } else if (_currentStep == 2) {
      if (_newPasswordController.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('A senha deve ter no mínimo 6 caracteres')));
        return;
      }
      if (_newPasswordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('As senhas não coincidem')));
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Senha redefinida com sucesso!')));
      Navigator.pop(context);
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
                    Container(width: 80, height: 80, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.lock_reset, size: 50, color: Color(0xFF0066CC))),
                    const SizedBox(height: 20),
                    const Text('Recuperar Senha', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Etapa ${_currentStep + 1} de 3', style: const TextStyle(color: Colors.white70, fontSize: 16)),
                    const SizedBox(height: 32),
                    
                    if (_currentStep == 0) ..._buildStep1(),
                    if (_currentStep == 1) ..._buildStep2(),
                    if (_currentStep == 2) ..._buildStep3(),
                    
                    const SizedBox(height: 32),
                    SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: _handleNextStep, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0), child: Text(_currentStep == 2 ? 'Redefinir Senha' : 'Continuar', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)))),
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

  List<Widget> _buildStep1() {
    return [
      const Text('Insira seus dados para recuperação', style: TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center),
      const SizedBox(height: 24),
      
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.isPolice ? 'Matrícula' : 'CPF', style: const TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 8),
          TextField(
            controller: _cpfController,
            inputFormatters: widget.isPolice ? [FilteringTextInputFormatter.digitsOnly] : [CpfInputFormatter()],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: widget.isPolice ? 'Digite sua matrícula' : '000.000.000-00',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      const SizedBox(height: 20),
      
      const Text('Método de Recuperação', style: TextStyle(color: Colors.white, fontSize: 16)),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: RadioListTile<String>(
              title: const Text('E-mail', style: TextStyle(color: Colors.white)),
              value: 'email',
              groupValue: _recoveryMethod,
              onChanged: (value) => setState(() => _recoveryMethod = value!),
              activeColor: const Color(0xFFFFC107),
              tileColor: Colors.white.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RadioListTile<String>(
              title: const Text('SMS', style: TextStyle(color: Colors.white)),
              value: 'sms',
              groupValue: _recoveryMethod,
              onChanged: (value) => setState(() => _recoveryMethod = value!),
              activeColor: const Color(0xFFFFC107),
              tileColor: Colors.white.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      
      if (_recoveryMethod == 'email')
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('E-mail', style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'seu@email.com',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
    ];
  }

  List<Widget> _buildStep2() {
    return [
      const Text('Digite o código recebido', style: TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center),
      const SizedBox(height: 8),
      Text('Enviamos um código para ${_recoveryMethod == 'email' ? 'seu e-mail' : 'seu telefone'}', style: const TextStyle(color: Colors.white70, fontSize: 14), textAlign: TextAlign.center),
      const SizedBox(height: 24),
      
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Código de Verificação', style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 8),
          TextField(
            controller: _codeController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, letterSpacing: 8),
            decoration: InputDecoration(
              hintText: '000000',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 24, letterSpacing: 8),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      Center(
        child: TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Novo código enviado!')));
          },
          child: const Text('Reenviar código', style: TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
        ),
      ),
    ];
  }

  List<Widget> _buildStep3() {
    return [
      const Text('Crie sua nova senha', style: TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center),
      const SizedBox(height: 24),
      
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nova Senha', style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 8),
          TextField(
            controller: _newPasswordController,
            obscureText: !_showNewPassword,
            maxLength: 8,
            decoration: InputDecoration(
              hintText: 'Digite sua nova senha (min. 6 caracteres)',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              counterText: '',
              suffixIcon: IconButton(
                icon: Icon(_showNewPassword ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                onPressed: () => setState(() => _showNewPassword = !_showNewPassword),
              ),
            ),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      const SizedBox(height: 20),
      
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Confirmar Nova Senha', style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 8),
          TextField(
            controller: _confirmPasswordController,
            obscureText: !_showConfirmPassword,
            maxLength: 8,
            decoration: InputDecoration(
              hintText: 'Digite novamente',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              counterText: '',
              suffixIcon: IconButton(
                icon: Icon(_showConfirmPassword ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                onPressed: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
              ),
            ),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    ];
  }
}
