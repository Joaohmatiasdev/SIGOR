import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_data.dart';

class ProtocolTrackingScreen extends StatefulWidget {
  const ProtocolTrackingScreen({Key? key}) : super(key: key);

  @override
  State<ProtocolTrackingScreen> createState() => _ProtocolTrackingScreenState();
}

class _ProtocolTrackingScreenState extends State<ProtocolTrackingScreen> {
  final TextEditingController _protocoloController = TextEditingController();
  String _protocoloError = '';
  Map<String, dynamic>? _foundOccurrence;

  @override
  void dispose() {
    _protocoloController.dispose();
    super.dispose();
  }

  void _handleSearch() {
    setState(() {
      _protocoloError = '';
      _foundOccurrence = null;
    });

    if (_protocoloController.text.isEmpty) {
      setState(() => _protocoloError = 'Digite um número de protocolo');
      return;
    }

    final found = AppData.occurrences.firstWhere(
      (occ) => occ['protocolo'] == _protocoloController.text,
      orElse: () => {},
    );

    if (found.isEmpty) {
      setState(() => _protocoloError = 'Protocolo não encontrado');
    } else {
      setState(() => _foundOccurrence = found);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.grey[200]),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFF0D47A1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Image.network(
                      '/images/image.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.shield, size: 40, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SIGOR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Consultar Protocolo',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Consultar Protocolo',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D47A1),
                          ),
                        ),
                        const SizedBox(height: 24),

                        const Text(
                          'Número do Protocolo',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _protocoloController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9-]'))
                          ],
                          decoration: InputDecoration(
                            hintText: 'Digite o número do protocolo',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        if (_protocoloError.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              _protocoloError,
                              style: const TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          ),
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'Digite apenas números e letras',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ),
                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _handleSearch,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFC107),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text(
                              'Consultar',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),

                        if (_foundOccurrence != null) ...[
                          const SizedBox(height: 32),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Protocolo: ${_foundOccurrence!['protocolo']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tipo: ${_foundOccurrence!['tipoEvento']}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Text(
                                  'Data: ${_foundOccurrence!['evento']}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Text(
                                  'Hora: ${_foundOccurrence!['hora']}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Text(
                                  'Local: ${_foundOccurrence!['endereco']}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Text(
                                  'Registrado por: ${_foundOccurrence!['nome']}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Text(
                                  'CPF: ${_foundOccurrence!['cpf']}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],

                        if (AppData.occurrences.isNotEmpty) ...[
                          const SizedBox(height: 32),
                          const Text(
                            'Todas as Ocorrências Registradas',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D47A1),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...AppData.occurrences.map((occ) => Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Protocolo: ${occ['protocolo']}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Tipo: ${occ['tipoEvento']}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      'Data: ${occ['evento']}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              )).toList(),
                        ],

                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF0D47A1),
                              side: const BorderSide(
                                color: Color(0xFF0D47A1),
                                width: 2,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text(
                              'Voltar ao Portal',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
