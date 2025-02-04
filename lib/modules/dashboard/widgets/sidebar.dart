import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  void _confirmSignOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar cierre de sesión"),
          content: Text("¿Estás seguro de que quieres cerrar sesión?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cerrar el diálogo
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar el diálogo
                _signOut(context); // Cerrar sesión
              },
              child: Text("Cerrar sesión", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login'); // Regresa al login
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.black,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "B&L MUEBLES",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 20),
          _sidebarItem(Icons.home, "Inicio", () {}),
          _sidebarItem(Icons.inventory, "Inventario", () {}),
          _sidebarItem(Icons.shopping_cart, "Pedidos", () {}),
          _sidebarItem(Icons.pending, "Pendiente", () {}),
          _sidebarItem(Icons.people, "Usuarios", () {}),
          Spacer(),
          _sidebarItem(Icons.exit_to_app, "Cerrar Sesión", () => _confirmSignOut(context)),
        ],
      ),
    );
  }

  Widget _sidebarItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
