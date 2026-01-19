import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    // CAPTURA AUTOMÁTICA: Pega o JSON vindo do Login/Registro
    final Map<String, dynamic> data = 
        (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?) ?? {};

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E19),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho com Nick e Status
              _header(data['usernick'] ?? 'HABITANTE', data['status'] ?? 'OFFLINE'),
              
              const SizedBox(height: 30),
              
              // Grade de Dados EnX
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2.2, // Ajustado para melhor leitura
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  children: [
                    _item("NATION", data['nat'] ?? '---'),
                    _item("GEOIP", data['geoip'] ?? '0.0.0.0'),
                    _item("DATETIME", data['datetime'] ?? '--/--/--'),
                    _item("ID_INASX", data['id_inasx'] ?? '---'),
                    _item("ID_PIGEON", data['id_pigeon'] ?? '---'),
                    _item("ID_MARKET", data['id_market'] ?? '---'),
                  ],
                ),
              ),
              
              const Center(
                child: Text("ENX CORE SYSTEM v1.0", 
                style: TextStyle(color: Colors.white10, fontSize: 10, letterSpacing: 4)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(String nick, String status) {
    bool isOp = status.toUpperCase() == "OPERACIONAL";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(nick.toUpperCase(), 
          style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isOp ? Colors.greenAccent.withOpacity(0.1) : Colors.redAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, color: isOp ? Colors.greenAccent : Colors.redAccent, size: 8),
              const SizedBox(width: 6),
              Text(status, 
                style: TextStyle(color: isOp ? Colors.greenAccent : Colors.redAccent, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _item(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9, letterSpacing: 1.5)),
        const SizedBox(height: 4),
        Text(value.toString(), 
          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
      ],
    );
  }
}
