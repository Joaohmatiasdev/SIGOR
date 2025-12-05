import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'occurrence_step3_screen.dart';

class OccurrenceStep2Screen extends StatefulWidget {
  final String evento;
  final String tipoEvento;
  final String tipoLocal;
  final String endereco;
  final String hora;
  final String descricaoDetalhada;

  const OccurrenceStep2Screen({
    Key? key,
    required this.evento,
    required this.tipoEvento,
    required this.tipoLocal,
    required this.endereco,
    required this.hora,
    required this.descricaoDetalhada, required String descricao, required List<String> arquivos,
  }) : super(key: key);

  @override
  State<OccurrenceStep2Screen> createState() => _OccurrenceStep2ScreenState();
}

class _OccurrenceStep2ScreenState extends State<OccurrenceStep2Screen> {
  // Armas
  final TextEditingController _tipoArmaController = TextEditingController();
  final TextEditingController _descricaoArmaController = TextEditingController();
  final TextEditingController _fabricanteController = TextEditingController();
  
  // Munições
  final TextEditingController _tipoMunicaoController = TextEditingController();
  final TextEditingController _quantidadeMunicaoController = TextEditingController();
  final TextEditingController _calibreController = TextEditingController();
  
  // Drogas
  final TextEditingController _tipoDrogaController = TextEditingController();
  final TextEditingController _quantidadeDrogaController = TextEditingController();
  final TextEditingController _unidadeDrogaController = TextEditingController();
  
  // Dinheiro
  final TextEditingController _valorDinheiroController = TextEditingController();
  final TextEditingController _moedaController = TextEditingController();
  
  // Objetos
  final TextEditingController _descricaoObjetoController = TextEditingController();
  final TextEditingController _quantidadeObjetoController = TextEditingController();
  
  // Veículos
  final TextEditingController _placaVeiculoController = TextEditingController();
  final TextEditingController _modeloVeiculoController = TextEditingController();
  final TextEditingController _corVeiculoController = TextEditingController();
  
  // Envolvidos
  final TextEditingController _nomeEnvolvidoController = TextEditingController();
  final TextEditingController _cpfEnvolvidoController = TextEditingController();
  final TextEditingController _tipoEnvolvimentoController = TextEditingController();
  
  // Policiais
  final TextEditingController _nomePolicialController = TextEditingController();
  final TextEditingController _matriculaPolicialController = TextEditingController();
  
  // Narrativa Técnica
  final TextEditingController _narrativaTecnicaController = TextEditingController();

  String _narrativaError = '';

  @override
  void dispose() {
    _tipoArmaController.dispose();
    _descricaoArmaController.dispose();
    _fabricanteController.dispose();
    _tipoMunicaoController.dispose();
    _quantidadeMunicaoController.dispose();
    _calibreController.dispose();
    _tipoDrogaController.dispose();
    _quantidadeDrogaController.dispose();
    _unidadeDrogaController.dispose();
    _valorDinheiroController.dispose();
    _moedaController.dispose();
    _descricaoObjetoController.dispose();
    _quantidadeObjetoController.dispose();
    _placaVeiculoController.dispose();
    _modeloVeiculoController.dispose();
    _corVeiculoController.dispose();
    _nomeEnvolvidoController.dispose();
    _cpfEnvolvidoController.dispose();
    _tipoEnvolvimentoController.dispose();
    _nomePolicialController.dispose();
    _matriculaPolicialController.dispose();
    _narrativaTecnicaController.dispose();
    super.dispose();
  }

  void _handleNext() {
    setState(() {
      _narrativaError = '';
    });

    // B.1 - Campo obrigatório: Narrativa Técnica
    if (_narrativaTecnicaController.text.isEmpty) {
      setState(() {
        _narrativaError = 'A Narrativa Técnica do Caso é obrigatória';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha a Narrativa Técnica do Caso para continuar'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OccurrenceStep3Screen(
          evento: widget.evento,
          tipoEvento: widget.tipoEvento,
          tipoLocal: widget.tipoLocal,
          endereco: widget.endereco,
          hora: widget.hora,
          descricaoDetalhada: widget.descricaoDetalhada,
          tipoArma: _tipoArmaController.text,
          descricaoArma: _descricaoArmaController.text,
          narrativaTecnica: _narrativaTecnicaController.text,
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
                          'Etapa 2: Detalhamento Completo da Ocorrência',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D47A1),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // D.2 - ENVOLVIDOS
                        _buildSectionTitle('1. Informações sobre Envolvidos'),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _nomeEnvolvidoController,
                          label: 'Nome do Envolvido',
                          hint: 'Nome completo',
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _cpfEnvolvidoController,
                          label: 'CPF do Envolvido',
                          hint: '000.000.000-00',
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _tipoEnvolvimentoController,
                          label: 'Tipo de Envolvimento',
                          hint: 'Ex: Vítima, Agressor, Testemunha',
                        ),
                        const SizedBox(height: 24),

                        // D.2 - ARMAS
                        _buildSectionTitle('2. Armas Apreendidas/Envolvidas'),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _tipoArmaController,
                          label: 'Tipo de Arma',
                          hint: 'Classificação da arma',
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _descricaoArmaController,
                          label: 'Descrição/Característica',
                          hint: 'Ex: Calibre .38, marca, cor, número...',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _fabricanteController,
                          label: 'Fabricante',
                          hint: 'Marca ou fabricante da arma',
                        ),
                        const SizedBox(height: 24),

                        // D.2 - MUNIÇÕES
                        _buildSectionTitle('3. Munições Apreendidas/Envolvidas'),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _tipoMunicaoController,
                          label: 'Tipo de Munição',
                          hint: 'Ex: 9mm, .38, .40',
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _quantidadeMunicaoController,
                                label: 'Quantidade',
                                hint: 'Ex: 50',
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildTextField(
                                controller: _calibreController,
                                label: 'Calibre',
                                hint: 'Ex: 9mm',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // D.2 - DROGAS
                        _buildSectionTitle('4. Drogas Apreendidas'),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _tipoDrogaController,
                          label: 'Tipo de Droga',
                          hint: 'Ex: Maconha, Cocaína, Crack',
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _quantidadeDrogaController,
                                label: 'Quantidade',
                                hint: 'Ex: 100',
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildTextField(
                                controller: _unidadeDrogaController,
                                label: 'Unidade',
                                hint: 'Ex: gramas (g), kg',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // D.2 - DINHEIRO
                        _buildSectionTitle('5. Dinheiro Apreendido'),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _valorDinheiroController,
                                label: 'Valor',
                                hint: 'Ex: 1500.00',
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildTextField(
                                controller: _moedaController,
                                label: 'Moeda',
                                hint: 'Ex: BRL, USD',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // D.2 - OBJETOS
                        _buildSectionTitle('6. Objetos Apreendidos/Envolvidos'),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _descricaoObjetoController,
                          label: 'Descrição do Objeto',
                          hint: 'Ex: Celular Samsung Galaxy, Notebook Dell',
                          maxLines: 2,
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _quantidadeObjetoController,
                          label: 'Quantidade',
                          hint: 'Ex: 2',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 24),

                        // D.2 - VEÍCULOS
                        _buildSectionTitle('7. Veículos Envolvidos'),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _placaVeiculoController,
                          label: 'Placa',
                          hint: 'Ex: ABC-1234',
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _modeloVeiculoController,
                          label: 'Modelo',
                          hint: 'Ex: Honda Civic 2020',
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _corVeiculoController,
                          label: 'Cor',
                          hint: 'Ex: Preto',
                        ),
                        const SizedBox(height: 24),

                        // D.2 - POLICIAIS ENVOLVIDOS
                        _buildSectionTitle('8. Policiais que Atenderam'),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _nomePolicialController,
                          label: 'Nome do Policial',
                          hint: 'Nome completo',
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _matriculaPolicialController,
                          label: 'Matrícula',
                          hint: 'Ex: 123456',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 24),

                        // D.2 - NARRATIVA TÉCNICA (OBRIGATÓRIO - B.1)
                        _buildSectionTitle('9. Narrativa Técnica do Caso *'),
                        const SizedBox(height: 8),
                        const Text(
                          'Campo obrigatório - Descreva tecnicamente todo o ocorrido',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _narrativaTecnicaController,
                          label: 'Narrativa Técnica',
                          hint:
                              'Descreva de forma técnica e circunstanciada todos os detalhes da ocorrência...',
                          maxLines: 6,
                          error: _narrativaError,
                        ),
                        if (_narrativaError.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              _narrativaError,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        const SizedBox(height: 32),

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
                                  'Voltar para Etapa 1',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _handleNext,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0D47A1),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                                child: const Text(
                                  'Avançar para Etapa 3',
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

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D47A1).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF0D47A1), width: 1),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0D47A1),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String error = '',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: error.isNotEmpty
                  ? const BorderSide(color: Colors.red, width: 2)
                  : BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: error.isNotEmpty
                  ? const BorderSide(color: Colors.red, width: 2)
                  : BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
