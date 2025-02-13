import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/search_bar.dart';
import '../widgets/inventory_table.dart';
import '../widgets/top_bar.dart';


class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  void _onAddProduct() {
    // Aquí se puede abrir un formulario para agregar productos
    print("Agregar producto presionado");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBar(title: "Inventario",),
                const SizedBox(height: 16), 
                const Center(
                  child: Text("Inventario", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                SearchBarWidget(onAddProduct: _onAddProduct),
                const InventoryTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
