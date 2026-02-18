import 'package:flutter/material.dart';
import '../viewmodels/registro_viewmodel.dart';

class RegistroView extends StatelessWidget {
  const RegistroView({super.key});

  @override
  Widget build(BuildContext context) {
    // Instanciamos el ViewModel
    final viewModel = RegisterViewmodel();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // El fondo gris de Figma
      body: Center(
        child: Container(
          width: 900,
          height: 600,
          clipBehavior: Clip.antiAlias, 
          decoration: BoxDecoration(
            color: const Color(0xFF1A1F3D), 
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/imagenRegistro.jpg'), 
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // COLUMNA DERECHA: EL FORMULARIO
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Únete a la arena',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Crea una cuenta',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      const SizedBox(height: 30),
                      
                      _buildInput(label: "Nombre usuario", controller: viewModel.nombreController),
                      _buildInput(label: "Email", controller: viewModel.emailController),
                      _buildInput(label: "Contraseña", controller: viewModel.passwordController, isSecret: true),
                      _buildInput(label: "Confirmar contraseña", controller: viewModel.confirmarpasswordController, isSecret: true),
                      
                      const SizedBox(height: 20),
                      
                      ElevatedButton(
                        onPressed: () => viewModel.registrarUsuario(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('¡A JUGAR!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

  // Método auxiliar para no repetir código de diseño de los inputs
  Widget _buildInput({required String label, required TextEditingController controller, bool isSecret = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: isSecret,
        decoration: InputDecoration(
          hintText: label,
          filled: true,
          fillColor: const Color(0xFFD9D9D9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
