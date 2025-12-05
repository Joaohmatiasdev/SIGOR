import 'package:flutter/material.dart';
import '../app_data.dart';
import '../services/pdf_generator.dart';
import 'package:open_file/open_file.dart';

class OccurrenceStep3Screen extends StatefulWidget {
  final String evento;
  final String tipoEvento;
  final String tipoLocal;
  final String endereco;
  final String hora;
  final String descricaoDetalhada;
  final String tipoArma;
  final String descricaoArma;
  final String narrativaTecnica;

  const OccurrenceStep3Screen({
    Key? key,
    required this.evento,
    required this.tipoEvento,
    required this.tipoLocal,
    required this.endereco,
    required this.hora,
    required this.descricaoDetalhada,
    required this.tipoArma,
    required this.descricaoArma,
    required this.narrativaTecnica,
  }) : super(key: key);

  @override
  State<OccurrenceStep3Screen> createState() => _OccurrenceStep3ScreenState();
}

class _OccurrenceStep3ScreenState extends State<OccurrenceStep3Screen> {
  final TextEditingController _assinaturaController = TextEditingController();
  final TextEditingController _protocoloController = TextEditingController();
  String _resumoIA = '';
  bool _isGeneratingSummary = false;
  bool _isGeneratingPdf = false;

  @override
  void initState() {
    super.initState();
    _generateProtocol();
  }

  @override
  void dispose() {
    _assinaturaController.dispose();
    _protocoloController.dispose();
    super.dispose();
  }

  void _generateProtocol() {
    final protocol = 'ROP-${DateTime.now().millisecondsSinceEpoch % 100000}';
    _protocoloController.text = protocol;
  }

  void _generateAISummary() {
    setState(() {
      _isGeneratingSummary = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      final summary = '''
📋 RESUMO INTELIGENTE DA OCORRÊNCIA

🔹 TIPO: ${widget.tipoEvento}
🔹 DATA/HORA: ${widget.evento} às ${widget.hora}
🔹 LOCAL: ${widget.endereco}

📝 DESCRIÇÃO RESUMIDA:
${widget.descricaoDetalhada.isNotEmpty ? _summarizeText(widget.descricaoDetalhada) : 'Não informada'}

⚠️ ELEMENTOS PRINCIPAIS:
${widget.tipoArma.isNotEmpty ? '• Arma: ${widget.tipoArma}' : ''}
${widget.descricaoArma.isNotEmpty ? '• Características: ${widget.descricaoArma}' : ''}

📖 NARRATIVA TÉCNICA (Resumo):
${_summarizeText(widget.narrativaTecnica)}

✅ STATUS: Aguardando validação final
🔒 PROTOCOLO: ${_protocoloController.text}
      ''';

      if (mounted) {
        setState(() {
          _resumoIA = summary;
          _isGeneratingSummary = false;
        });
      }
    });
  }

  String _summarizeText(String text) {
    if (text.isEmpty) return 'Não informado';
    if (text.length <= 150) return text;
    return '${text.substring(0, 150)}...';
  }

  void _handleFinish() {
    final occurrence = {
      'protocolo': _protocoloController.text,
      'evento': widget.evento,
      'tipoEvento': widget.tipoEvento,
      'endereco': widget.endereco,
      'hora': widget.hora,
      'descricaoDetalhada': widget.descricaoDetalhada,
      'narrativaTecnica': widget.narrativaTecnica,
      'nome': AppData.userName,
      'cpf': AppData.userCpf,
      'data': DateTime.now().toString(),
      'resumoIA': _resumoIA,
    };

    AppData.occurrences.add(occurrence);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ocorrência registrada! Protocolo: ${_protocoloController.text}'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  Future<void> _generatePdf() async {
    setState(() {
      _isGeneratingPdf = true;
    });

    try {
      final occurrence = {
        'protocolo': _protocoloController.text,
        'evento': widget.evento,
        'tipoEvento': widget.tipoEvento,
        'endereco': widget.endereco,
        'hora': widget.hora,
        'descricaoDetalhada': widget.descricaoDetalhada,
        'narrativaTecnica': widget.narrativaTecnica,
        'nome': AppData.userName,
        'cpf': AppData.userCpf,
        'data': DateTime.now().toString(),
        'resumoIA': _resumoIA,
      };

      final pdfFile = await PdfGenerator.generateOccurrencePdf(occurrence);

      if (mounted) {
        setState(() {
          _isGeneratingPdf = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF gerado com sucesso! Local: ${pdfFile.path}'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'ABRIR',
              textColor: Colors.white,
              onPressed: () {
                OpenFile.open(pdfFile.path);
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isGeneratingPdf = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao gerar PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
                            'Abertura de Ocorrência',
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
                          'Etapa 3: Validação e Documentação',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D47A1),
                          ),
                        ),
                        const SizedBox(height: 24),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                                size: 40,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Sumarização Inteligente com IA',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Gere um resumo automático dos principais pontos da ocorrência',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: _isGeneratingSummary ? null : _generateAISummary,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF0D47A1),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                  ),
                                  icon: _isGeneratingSummary
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(Color(0xFF0D47A1)),
                                          ),
                                        )
                                      : const Icon(Icons.auto_awesome),
                                  label: Text(
                                    _isGeneratingSummary
                                        ? 'Gerando Resumo...'
                                        : 'Gerar Resumo Inteligente',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (_resumoIA.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green, width: 2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.green, size: 24),
                                    SizedBox(width: 8),
                                    Text(
                                      'Resumo Gerado com Sucesso',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  _resumoIA,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 24),

                        const Text(
                          'Geração do Protocolo/ID',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _protocoloController,
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.qr_code),
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D47A1),
                          ),
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          'Assinatura Digital (Opcional)',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _assinaturaController,
                          decoration: InputDecoration(
                            hintText: 'Ex: Assinado digitalmente por João Silva',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _isGeneratingPdf ? null : _generatePdf,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            icon: _isGeneratingPdf
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : const Icon(Icons.picture_as_pdf, color: Colors.white),
                            label: Text(
                              _isGeneratingPdf ? 'Gerando PDF...' : 'Gerar PDF (Normas ABNT)',
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '📄 PDF formatado conforme normas ABNT NBR 6023',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
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
                                  'Voltar para Etapa 2',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _handleFinish,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0D47A1),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                                child: const Text(
                                  'Finalizar Ocorrência',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
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
