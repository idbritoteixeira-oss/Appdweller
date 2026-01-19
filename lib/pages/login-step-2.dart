import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginStep2 extends StatefulWidget {
  const LoginStep2({super.key});

  @override
  _LoginStep2State createState() => _LoginStep2State();
}

class _LoginStep2State extends State<LoginStep2> {
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;
  bool _obscure = true;

  Future<void> _attemptLogin(String pubId) async {
    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8080/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'pub': pubId,
          'key': _passController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        // ENX CONSOLIDADO: Enviando todos os dados do servidor para a Dashboard
        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(
          context, 
          '/dashboard', 
          (route) => false,
          arguments: data, // <--- Aqui passamos Usernick, GeoIP e IDs
        );
      } else {
        _showError(data['message'] ?? "Credenciais inválidas.");
      }
    } catch (e) {
      _showError("Erro de conexão com o Núcleo.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String pubId = args['pub'];

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E19), // Cor de fundo padrão EnX
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("SECURITY KEY", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
              Text("ID: $pubId", style: const TextStyle(color: Colors.white24, fontSize: 12)),
              const SizedBox(height: 50),
              TextField(
                controller: _passController,
                obscureText: _obscure,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: const TextStyle(color: Colors.white, letterSpacing: 5),
                onChanged: (v) => setState(() {}), // Atualiza estado do botão
                decoration: InputDecoration(
                  labelText: "INSIRA SUA SENHA",
                  labelStyle: const TextStyle(color: Colors.white38),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off, color: Colors.white38),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: (_passController.text.length == 6 && !_isLoading) 
                      ? () => _attemptLogin(pubId) 
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D2A4E),
                    disabledBackgroundColor: Colors.white10
                  ),
                  child: _isLoading 
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                      : const Text("ACESSAR SISTEMA", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
