import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    // Memória-segmentada: Captura e trata os dados como Map
    final dynamic args = ModalRoute.of(context)?.settings.arguments;
    final Map<String, dynamic> data = (args is Map<String, dynamic>) ? args : {};

    return Scaffold(
      backgroundColor: const Color(0xFF020306), // Fundo profundo EnX
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _header(data['usernick']?.toString() ?? 'HABITANTE', data['status']?.toString() ?? 'OFFLINE'),
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white24, size: 20),
                    onPressed: () => Navigator.pushReplacementNamed(context, '/login-step-1'),
                  )
                ],
              ),
              
              const SizedBox(height: 40),
              
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 25,
                  children: [
                    _item("NATION", data['nat']),
                    _item("GEOIP", data['geoip']),
                    _item("DATETIME", data['datetime']),
                    _item("ID_INASX", data['id_inasx']),
                    _item("ID_PIGEON", data['id_pigeon']),
                    _item("ID_MARKET", data['id_market']),
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
          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isOp ? Colors.greenAccent.withOpacity(0.05) : Colors.redAccent.withOpacity(0.05),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: isOp ? Colors.greenAccent.withOpacity(0.2) : Colors.redAccent.withOpacity(0.2))
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, color: isOp ? Colors.greenAccent : Colors.redAccent, size: 6),
              const SizedBox(width: 8),
              Text(status, 
                style: TextStyle(color: isOp ? Colors.greenAccent : Colors.redAccent, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _item(String label, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        const SizedBox(height: 4),
        Text(
          (value == null || value.toString().isEmpty) ? "---" : value.toString(), 
          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'monospace'),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
