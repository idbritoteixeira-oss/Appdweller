import 'package:flutter/material.dart';

class LoginStep1 extends StatefulWidget {
  const LoginStep1({super.key});

  @override
  _LoginStep1State createState() => _LoginStep1State();
}

class _LoginStep1State extends State<LoginStep1> {
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isIdValid = _idController.text.length >= 3; // Mínimo para busca

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("ENTRANCE", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 10),
            const Text("Insira seu ID Público para identificação.", style: TextStyle(color: Colors.white38, fontSize: 12)),
            
            const SizedBox(height: 50),

            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                labelText: "PUBLIC ID",
                hintText: "000.000.000",
                counterStyle: TextStyle(color: Colors.white24),
              ),
              onChanged: (val) => setState(() {}),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isIdValid 
                  ? () => Navigator.pushNamed(context, '/login-step-2', arguments: {'pub': _idController.text})
                  : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D2A4E),
                  disabledBackgroundColor: Colors.white10,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: const Text("VERIFICAR IDENTIDADE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
