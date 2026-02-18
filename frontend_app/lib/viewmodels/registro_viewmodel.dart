import 'package:flutter/material.dart';

// ChangeNotifier avisa a la interfaz cuando algo cambie en la pantalla 
class RegisterViewmodel extends ChangeNotifier {
  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmarpasswordController = TextEditingController();

  void registrarUsuario(){
    final String nombre = nombreController.text; //Extrae las cadenas de texto 
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmarPassword = confirmarpasswordController.text;

    List<String> errores = [];

    if(nombreController.text.isEmpty) errores.add("nombre");
    if(emailController.text.isEmpty) errores.add("email");
    if(passwordController.text.isEmpty) errores.add("contraseña");
    if(confirmarpasswordController.text.isEmpty) errores.add("confirmar contraseña");

    if(errores.isNotEmpty){
      switch(errores.length){
        case 1:
          _showErrorMessage("Falta el campo ${errores[0]}");
          break;
        case 2:
          _showErrorMessage("Faltan los campos: ${errores.join(' y ')}");
          break;
        case 3:
          _showErrorMessage("Faltan todos los campos. Introduce los datos");
          break;
      }
      return;
    }

    if(password != confirmarPassword){
      _showErrorMessage("Contraseñas no coincidentes.");
      return;
    }

    _enviarAlBackend(nombre, email, password);

  }

  void _enviarAlBackend(String nombre, String email, String password){
    _showErrorMessage("Contraseñas no coincidentes.");
  }


void _showErrorMessage(String mensaje){
  debugPrint("ALERTA DE VALIDACIÓN: $mensaje");
}

  //Liberar memoria 
  @override
  void dispose(){
    nombreController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmarpasswordController.dispose();
    super.dispose();
  }
}
