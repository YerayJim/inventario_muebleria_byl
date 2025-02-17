import 'package:flutter/material.dart';
import 'package:inventario_muebleria_byl/modules/dashboard/views/add_product_screen.dart';
import '../widgets/sidebar.dart';
import '../widgets/search_bar.dart';
import '../widgets/inventory_table.dart';
import '../widgets/top_bar.dart';

class OrdersView extends StatelessWidget {
   void _navigateToAddProduct(BuildContext context) {
   showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      // Controla el ancho máximo del modal (60% del ancho de pantalla)
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500), // Ancho máximo fijo
        child: const AddInventoryScreen(),
      ),
    ),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TopBar(title: "Pedidos",),
                SearchBarWidget(onAddProduct: () => _navigateToAddProduct(context),),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                Expanded( 
                  child: Container(
                    width: double.infinity, // Ocupa todo el ancho disponible
                    padding: const EdgeInsets.symmetric(horizontal: 16), // Margen lateral opcional
                    child: const InventoryTable(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}