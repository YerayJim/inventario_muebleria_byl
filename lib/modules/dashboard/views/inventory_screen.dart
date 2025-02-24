import 'package:flutter/material.dart';
import 'package:inventario_muebleria_byl/modules/dashboard/views/add_product_screen.dart';
import '../widgets/sidebar.dart';
import '../widgets/search_bar.dart';
import '../widgets/inventory_table.dart';
import '../widgets/top_bar.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final GlobalKey<InventoryTableState> _inventoryTableKey = GlobalKey<InventoryTableState>();

  void _navigateToAddProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
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
                TopBar(title: "Inventario"),
                SearchBarWidget(
                  onAddProduct: () => _navigateToAddProduct(context),
                  onSearch: (query) => _inventoryTableKey.currentState?.updateSearchQuery(query),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InventoryTable(key: _inventoryTableKey),
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
