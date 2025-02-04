import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.black,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text("B&L MUEBLES",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          const SizedBox(height: 20),
          _sidebarItem(Icons.home, "Inicio"),
          _sidebarItem(Icons.inventory, "Inventario"),
          _sidebarItem(Icons.shopping_cart, "Pedidos"),
          _sidebarItem(Icons.pending, "Pendiente"),
          _sidebarItem(Icons.people, "Usuarios"),
          Spacer(),
          _sidebarItem(Icons.exit_to_app, "Cerrar Sesión"),
        ],
      ),
    );
  }

  Widget _sidebarItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: () {
        // Aquí puedes agregar la navegación
      },
    );
  }
}
