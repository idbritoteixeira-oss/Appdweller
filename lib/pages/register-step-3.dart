import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterStep3 extends StatefulWidget {
  const RegisterStep3({super.key}); // Removidos os parâmetros obrigatórios daqui

  @override
  _RegisterStep3State createState() => _RegisterStep3State();
}

class _RegisterStep3State extends State<RegisterStep3> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _obscure = true;
  bool _isLoading = false;

  Future<void> _sendToIntegration() async {
    // Captura os argumentos vindos do Step 2
    final Map<String, dynamic> args = 
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    
    final String nick = args['nick'];
    final String nation = args['nation'];

    setState(() => _isLoading = true);
    
    try {
      final response = await http.post(
        Uri.parse('https://8b48ce67-8062-40e3-be2d-c28fd3ae4f01-00-117turwazmdmc.janeway.replit.dev/integration'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nick': nick,
          'key': _passController.text,
          'nat': nation,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        if (mounted) {
          Navigator.pushNamed(context, '/register-step-4', arguments: data);
        }
      } else {
        _showSnackbar(data['message'] ?? "Erro na integração");
      }
    } catch (e) {
      _showSnackbar("Falha na conexão com o Núcleo EnX");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ... (restante do código build, tutorialBox e field permanecem iguais)
  void _showSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    bool isReady = _passController.text.length == 6 && 
                  _passController.text == _confirmController.text;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("SECURITY KEY", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
              const SizedBox(height: 40),
              _buildField(_passController, "PASSWORD (6 DÍGITOS)", true),
              const SizedBox(height: 20),
              _buildField(_confirmController, "CONFIRM PASSWORD", false),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: (isReady && !_isLoading) ? _sendToIntegration : null,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1D2A4E)),
                  child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white) 
                    : const Text("FINALIZAR REGISTRO"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl, String label, bool suffix) {
    return TextField(
      controller: ctrl,
      obscureText: _obscure,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      maxLength: 6,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffix ? IconButton(
          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off, color: Colors.white38),
          onPressed: () => setState(() => _obscure = !_obscure),
        ) : null,
      ),
      onChanged: (val) => setState(() {}),
    );
  }
}
