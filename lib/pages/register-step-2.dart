import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterStep2 extends StatefulWidget {
  @override
  _RegisterStep2State createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {
  final TextEditingController _nickController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.white)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("USERNICK", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
              const SizedBox(height: 20),

              // Tutorial Corrigido
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D2A4E).withOpacity(0.1),
                  border: Border.all(color: const Color(0xFF1D2A4E), width: 0.5),
                ),
                child: const Text(
                  "GUIA DE IDENTIDADE:\n1. O UserNick é seu nome público.\n2. Apenas letras, números e underline (_).\n3. Mínimo de 3 caracteres.",
                  style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: _nickController,
                style: const TextStyle(color: Colors.white),
                maxLength: 16,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
                ],
                decoration: const InputDecoration(
                  labelText: "NOME DE EXIBIÇÃO",
                  hintText: "Ex: EnX_Dweller",
                  filled: true,
                  fillColor: Color(0x1A1D2A4E),
                ),
                onChanged: (val) => setState(() {}),
              ),
              
              const SizedBox(height: 30),
              
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _nickController.text.length >= 3 
                    ? () => Navigator.pushNamed(context, '/register-step-3') 
                    : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D2A4E),
                    disabledBackgroundColor: Colors.white10,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: const Text("VINCULAR IDENTIDADE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
