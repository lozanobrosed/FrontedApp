import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String playerName;
  final int coins;

  const HomeScreen({
    super.key,
    required this.playerName,
    required this.coins,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Para el “menú inferior” (Amigos / Tienda / Perfil)
  int _bottomIndex = 0;

  // Placeholder: aquí en el futuro harás Navigator.push(...)
  void _openFutureScreen(String routeName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ir a: $routeName (pendiente)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Colores aproximados a la imagen
    const bg = Color(0xFF2D3473);
    const panel = Color(0xFF3A4288);
    const card = Color(0xFF2A316B);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              // TOP BAR: Logo + monedas + jugador
              Row(
                children: [
                  _Logo(),
                  const Spacer(),
                  _Pill(
                    child: Row(
                      children: [
                        const Icon(Icons.attach_money, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          widget.coins.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    background: const Color(0xFFF4C542),
                    foreground: Colors.black,
                  ),
                  const SizedBox(width: 10),
                  _Pill(
                    child: Row(
                      children: [
                        const Icon(Icons.person, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          widget.playerName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    background: const Color(0xFF7E8AA3),
                    foreground: Colors.black,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Panel principal
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: panel,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 6),
                      const Text(
                        '¡Bienvenido!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Elige un modo de juego para empezar',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 18),

                      // “Carrusel” con flechas laterales + dos tarjetas
                      Expanded(
                        child: Row(
                          children: [
                            _ArrowButton(
                              onTap: () {
                                // En el futuro: mover carrusel
                              },
                              icon: Icons.chevron_left,
                            ),
                            const SizedBox(width: 10),

                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _ModeCard(
                                      background: card,
                                      title: 'Modo con roles',
                                      icon: Icons.theater_comedy,
                                      description:
                                          'Cada jugador recibe un rol\nespecial con habilidades únicas',
                                      onPublic: () => _openFutureScreen(
                                          'roles_publica'),
                                      onPrivate: () => _openFutureScreen(
                                          'roles_privada'),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: _ModeCard(
                                      background: card,
                                      title: 'Modo cartas',
                                      icon: Icons.flash_on,
                                      description:
                                          'Nuevas cartas que modifican las\nreglas del juego',
                                      onPublic: () => _openFutureScreen(
                                          'cartas_publica'),
                                      onPrivate: () => _openFutureScreen(
                                          'cartas_privada'),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 10),
                            _ArrowButton(
                              onTap: () {
                                // En el futuro: mover carrusel
                              },
                              icon: Icons.chevron_right,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Bottom “botones” Amigos / Tienda / Perfil
                      _BottomMenu(
                        currentIndex: _bottomIndex,
                        onTap: (i) {
                          setState(() => _bottomIndex = i);

                          if (i == 0) _openFutureScreen('amigos');
                          if (i == 1) _openFutureScreen('tienda');
                          if (i == 2) _openFutureScreen('perfil');
                        },
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
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.transparent,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          // Si aún no tienes logo, no crashea: muestra un icono.
          errorBuilder: (context, error, stack) => Container(
            color: const Color(0xFF1F2454),
            child: const Icon(Icons.image, color: Colors.white70),
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final Widget child;
  final Color background;
  final Color foreground;

  const _Pill({
    required this.child,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: foreground),
        child: IconTheme(
          data: IconThemeData(color: foreground),
          child: child,
        ),
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;

  const _ArrowButton({required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 36,
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFF263064),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: Colors.white70, size: 28),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final Color background;
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onPublic;
  final VoidCallback onPrivate;

  const _ModeCard({
    required this.background,
    required this.title,
    required this.description,
    required this.icon,
    required this.onPublic,
    required this.onPrivate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12.5,
              height: 1.2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'Partida pública',
                  background: const Color(0xFF53D86A),
                  foreground: Colors.black,
                  onTap: onPublic,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionButton(
                  label: 'Partida privada',
                  background: const Color(0xFF2F6BFF),
                  foreground: Colors.white,
                  onTap: onPrivate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: foreground,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomMenu extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const _BottomMenu({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF2A316B),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: _BottomItem(
              selected: currentIndex == 0,
              icon: Icons.group,
              label: 'Amigos',
              onTap: () => onTap(0),
            ),
          ),
          Expanded(
            child: _BottomItem(
              selected: currentIndex == 1,
              icon: Icons.store,
              label: 'Tienda',
              onTap: () => onTap(1),
            ),
          ),
          Expanded(
            child: _BottomItem(
              selected: currentIndex == 2,
              icon: Icons.person,
              label: 'Perfil',
              onTap: () => onTap(2),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _BottomItem({
    required this.selected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected ? const Color(0xFF3A6BFF) : const Color(0xFF263064);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}