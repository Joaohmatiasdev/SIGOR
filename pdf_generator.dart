import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class PdfGenerator {
  // Gera PDF de Ocorrência Policial seguindo normas ABNT
  static Future<File> generateOccurrencePdf(Map<String, dynamic> occurrence) async {
    final pdf = pw.Document();
    final now = DateTime.now();
    final dateFormat = DateFormat('dd/MM/yyyy');
    final timeFormat = DateFormat('HH:mm');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(2.5 * PdfPageFormat.cm), // Margem ABNT: 2.5cm
        build: (pw.Context context) {
          return [
            // Cabeçalho ABNT
            _buildHeader(),
            pw.SizedBox(height: 30),

            // Título centralizado, negrito, maiúsculo (ABNT)
            pw.Center(
              child: pw.Text(
                'REGISTRO DE OCORRÊNCIA POLICIAL',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Center(
              child: pw.Text(
                'ROP - POLÍCIA MILITAR DE SERGIPE',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 30),

            // Protocolo destacado
            _buildSection('PROTOCOLO', occurrence['protocolo'] ?? 'N/A'),
            pw.SizedBox(height: 20),

            // 1. DADOS DA OCORRÊNCIA
            _buildSectionTitle('1 DADOS FUNDAMENTAIS DA OCORRÊNCIA'),
            pw.SizedBox(height: 10),
            _buildField('Tipo de Evento', occurrence['tipoEvento'] ?? 'Não informado'),
            _buildField('Data do Evento', occurrence['evento'] ?? 'Não informada'),
            _buildField('Horário', occurrence['hora'] ?? 'Não informado'),
            _buildField('Local da Ocorrência', occurrence['endereco'] ?? 'Não informado'),
            pw.SizedBox(height: 15),

            // 2. DESCRIÇÃO DETALHADA
            _buildSectionTitle('2 DESCRIÇÃO DETALHADA'),
            pw.SizedBox(height: 10),
            _buildTextBlock(occurrence['descricaoDetalhada'] ?? 'Não informada'),
            pw.SizedBox(height: 15),

            // 3. NARRATIVA TÉCNICA
            _buildSectionTitle('3 NARRATIVA TÉCNICA DO CASO'),
            pw.SizedBox(height: 10),
            _buildTextBlock(occurrence['narrativaTecnica'] ?? 'Não informada'),
            pw.SizedBox(height: 15),

            // 4. RESUMO INTELIGENTE (IA)
            if (occurrence['resumoIA'] != null && occurrence['resumoIA'].toString().isNotEmpty) ...[
              _buildSectionTitle('4 SUMARIZAÇÃO INTELIGENTE'),
              pw.SizedBox(height: 10),
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey400),
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
                ),
                child: pw.Text(
                  occurrence['resumoIA'],
                  style: const pw.TextStyle(fontSize: 10),
                  textAlign: pw.TextAlign.justify,
                ),
              ),
              pw.SizedBox(height: 15),
            ],

            // 5. DADOS DO SOLICITANTE
            _buildSectionTitle('5 IDENTIFICAÇÃO DO SOLICITANTE'),
            pw.SizedBox(height: 10),
            _buildField('Nome Completo', occurrence['nome'] ?? 'Não informado'),
            _buildField('CPF', occurrence['cpf'] ?? 'Não informado'),
            pw.SizedBox(height: 15),

            // 6. INFORMAÇÕES DO REGISTRO
            _buildSectionTitle('6 INFORMAÇÕES DO REGISTRO'),
            pw.SizedBox(height: 10),
            _buildField('Data de Registro', dateFormat.format(now)),
            _buildField('Horário de Registro', timeFormat.format(now)),
            _buildField('Sistema', 'SIGOR - Sistema Integrado de Gestão de Ocorrência'),
            pw.SizedBox(height: 30),

            // Assinatura digital
            pw.Divider(thickness: 1),
            pw.SizedBox(height: 10),
            pw.Center(
              child: pw.Text(
                'DOCUMENTO GERADO DIGITALMENTE',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Center(
              child: pw.Text(
                'Protocolo: ${occurrence['protocolo']}',
                style: const pw.TextStyle(fontSize: 9),
              ),
            ),
            pw.Center(
              child: pw.Text(
                'Gerado em: ${dateFormat.format(now)} às ${timeFormat.format(now)}',
                style: const pw.TextStyle(fontSize: 9),
              ),
            ),

            // Rodapé ABNT
            pw.Spacer(),
            _buildFooter(),
          ];
        },
      ),
    );

    // Salvar arquivo
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/ROP_${occurrence['protocolo']}.pdf');
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  // Cabeçalho ABNT
  static pw.Widget _buildHeader() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'POLÍCIA MILITAR DE SERGIPE',
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'SIGOR - Sistema Integrado de Gestão de Ocorrência',
                  style: const pw.TextStyle(fontSize: 9),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 5),
        pw.Divider(thickness: 2),
      ],
    );
  }

  // Rodapé ABNT
  static pw.Widget _buildFooter() {
    return pw.Column(
      children: [
        pw.Divider(thickness: 1),
        pw.SizedBox(height: 5),
        pw.Text(
          'Este documento possui validade jurídica e foi gerado pelo Sistema SIGOR.',
          style: const pw.TextStyle(fontSize: 8),
          textAlign: pw.TextAlign.center,
        ),
        pw.Text(
          'Polícia Militar de Sergipe - Avenida Exemplo, 123 - Aracaju/SE',
          style: const pw.TextStyle(fontSize: 8),
          textAlign: pw.TextAlign.center,
        ),
      ],
    );
  }

  // Título de seção ABNT (negrito, sem indentação)
  static pw.Widget _buildSectionTitle(String title) {
    return pw.Text(
      title,
      style: pw.TextStyle(
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
      ),
    );
  }

  // Seção com destaque
  static pw.Widget _buildSection(String label, String value) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey200,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
      ),
      child: pw.Row(
        children: [
          pw.Text(
            '$label: ',
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            value,
            style: const pw.TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }

  // Campo de dados
  static pw.Widget _buildField(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 150,
            child: pw.Text(
              '$label:',
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              style: const pw.TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  // Bloco de texto justificado (ABNT)
  static pw.Widget _buildTextBlock(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
      ),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 10),
        textAlign: pw.TextAlign.justify, // Justificado conforme ABNT
      ),
    );
  }
}
