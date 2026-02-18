class Usuario{
  final String nombre;
  final String email;
  final String password;

  //Constructor 
  Usuario({
    required this.nombre,
    required this.email,
    required this.password,
  });

  @override
  String toString() => 'Usuario(nombre: $nombre, email: $email)';
}

