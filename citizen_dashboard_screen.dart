import 'package:flutter/material.dart';
import '../app_data.dart';
import 'occurrence_step1_screen.dart';
import 'protocol_tracking_screen.dart';
import 'messaging_screen.dart';
import 'personal_data_screen.dart';

class CitizenDashboardScreen extends StatelessWidget {
  const CitizenDashboardScreen({Key? key}) : super(key: key);

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
                          Text('Portal do Cidadão',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(AppData.userName ?? 'Usuário',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                        Text('CPF: ${AppData.userCpf ?? "000.000.000-00"}',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color(0xFF0D47A1), width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Bem-vindo ao Portal do Cidadão',
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0D47A1))),
                            const SizedBox(height: 8),
                            Text(
                                'Neste portal você pode acompanhar e criar suas ocorrências, acessar informações sigilosas. Utilize os serviços disponíveis para se comunicar com a Polícia Militar de Sergipe.',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[700])),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildServiceCard(
                        context,
                        icon: Icons.description,
                        title: 'Abertura de Ocorrência',
                        subtitle: 'Registre uma nova ocorrência policial',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const OccurrenceStep1Screen())),
                      ),
                      const SizedBox(height: 16),
                      _buildServiceCard(
                        context,
                        icon: Icons.search,
                        title: 'Acompanhamento de Protocolo',
                        subtitle:
                            'Consulte o status das suas ocorrências registradas',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProtocolTrackingScreen())),
                      ),
                      const SizedBox(height: 16),
                      _buildServiceCard(
                        context,
                        icon: Icons.message,
                        title: 'Comunicação com a PM',
                        subtitle: 'Envie mensagens para contato direto',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MessagingScreen(isPolice: false))),
                      ),
                      const SizedBox(height: 16),
                      _buildServiceCard(
                        context,
                        icon: Icons.person,
                        title: 'Dados Pessoais',
                        subtitle: 'Gerencie suas informações de cadastro',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PersonalDataScreen())),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  Navigator.popUntil(context, (route) => route.isFirst),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF0D47A1),
                                side: const BorderSide(
                                    color: Color(0xFF0D47A1), width: 2),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: const Text('Sair',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF0D47A1),
                                side: const BorderSide(
                                    color: Color(0xFF0D47A1), width: 2),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: const Text('Voltar ao Topo',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF0D47A1), width: 2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0D47A1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 26),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D47A1))),
                      const SizedBox(height: 4),
                      Text(subtitle,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey[600])),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
