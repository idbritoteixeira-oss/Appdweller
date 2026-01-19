import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020306), // Fundo Black EnX
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          children: [
            const Spacer(flex: 5),
            
            // Ícone de Profile no lugar do logo
            const Icon(
              Icons.fingerprint,
              size: 100,
              color: Color(0xFF1D2A4E),
            ),
            
            const SizedBox(height: 10),
            
            const Text(
              "DWELLERS",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w200,
                letterSpacing: 6,
              ),
            ),
            
            const Spacer(flex: 6),
            
            // Botão LOGIN (Quadrado - Cor 1D2A4E)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/login-step-1'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D2A4E),
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  elevation: 0,
                ),
                child: const Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 2),
                ),
              ),
            ),
            
            const SizedBox(height: 15),
            
            // Botão REGISTER (Quadrado - Outline 1D2A4E)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/register-step-1'),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF1D2A4E), width: 1.5),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: const Text(
                  "REGISTER",
                  style: TextStyle(color: Colors.white, letterSpacing: 2),
                ),
              ),
            ),
            
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
