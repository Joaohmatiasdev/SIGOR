import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'occurrence_step2_screen.dart';

class OccurrenceStep1Screen extends StatefulWidget {
  const OccurrenceStep1Screen({Key? key}) : super(key: key);

  @override
  State<OccurrenceStep1Screen> createState() => _OccurrenceStep1ScreenState();
}

class _OccurrenceStep1ScreenState extends State<OccurrenceStep1Screen> {
  final TextEditingController _eventoController = TextEditingController();
  final TextEditingController _tipoEventoController = TextEditingController();
  final TextEditingController _tipoLocalController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  List<String> _uploadedFiles = [];

  final List<String> _eventTypes = [
    'Roubo',
    'Furto',
    'Acidente de Trânsito',
    'Agressão',
    'Perturbação da Ordem',
    'Tráfico de Drogas',
    'Homicídio',
    'Outros'
  ];

  @override
  void dispose() {
    _eventoController.dispose();
    _tipoEventoController.dispose();
    _tipoLocalController.dispose();
    _enderecoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _eventoController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _handleFileUpload() {
    setState(() {
      _uploadedFiles.add('arquivo_${_uploadedFiles.length + 1}.jpg');
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Arquivo anexado com sucesso!')),
    );
  }

  void _handleNext() {
    if (_eventoController.text.isEmpty ||
        _tipoEventoController.text.isEmpty ||
        _enderecoController.text.isEmpty ||
        _descricaoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OccurrenceStep2Screen(
          evento: _eventoController.text,
          tipoEvento: _tipoEventoController.text,
          tipoLocal: _tipoLocalController.text,
          endereco: _enderecoController.text,
          descricao: _descricaoController.text,
          hora: _selectedTime != null
              ? '${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
              : '',
          arquivos: _uploadedFiles, descricaoDetalhada: '',
        ),
      ),
    );
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
                          Text('SIGOR',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text('Abertura de Ocorrência',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 13)),
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
                        const Text('Etapa 1: Dados Fundamentais da Ocorrência',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0D47A1))),
                        const SizedBox(height: 24),
                        const Text('Evento',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _eventoController,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: InputDecoration(
                            hintText: 'Selecione a data',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            suffixIcon: const Icon(Icons.calendar_today),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('Selecione o tipo de evento',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: 'Selecione o tipo',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          items: _eventTypes.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _tipoEventoController.text = newValue ?? '';
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Horário',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 8),
                                  InkWell(
                                    onTap: () => _selectTime(context),
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey[300]!),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _selectedTime != null
                                                ? '${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                                                : 'Selecione',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: _selectedTime != null
                                                  ? Colors.black
                                                  : Colors.grey[600],
                                            ),
                                          ),
                                          const Icon(Icons.access_time),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text('Tipo de Local',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _tipoLocalController,
                          decoration: InputDecoration(
                            hintText: 'Ex: Identificação do local da ocorrência',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('Endereço Específico',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _enderecoController,
                          decoration: InputDecoration(
                            hintText: 'Ex: Localização',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            suffixIcon: const Icon(Icons.map, color: Color(0xFF0D47A1)),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text('Clique no ícone do mapa para visualizar localização',
                              style: TextStyle(color: Colors.grey, fontSize: 13)),
                        ),
                        const SizedBox(height: 20),
                        const Text('Descrição Detalhada da Ocorrência *',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _descricaoController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Descreva detalhadamente o que aconteceu...',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('Anexar Arquivos (Fotos, Vídeos, Documentos)',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: _handleFileUpload,
                          icon: const Icon(Icons.attach_file),
                          label: const Text('Selecionar Arquivos'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF0D47A1),
                            side: const BorderSide(
                                color: Color(0xFF0D47A1), width: 2),
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 20),
                          ),
                        ),
                        if (_uploadedFiles.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          ..._uploadedFiles.map((file) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    const Icon(Icons.check_circle,
                                        color: Colors.green, size: 20),
                                    const SizedBox(width: 8),
                                    Text(file,
                                        style: const TextStyle(fontSize: 14)),
                                  ],
                                ),
                              )),
                        ],
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF0D47A1),
                                  side: const BorderSide(
                                      color: Color(0xFF0D47A1), width: 2),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                ),
                                child: const Text('Voltar',
                                    style: TextStyle(fontSize: 16)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _handleNext,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0D47A1),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                ),
                                child: const Text('Avançar para Etapa 2',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ),
                            ),
                          ],
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
