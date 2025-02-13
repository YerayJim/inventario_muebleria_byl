import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryTable extends StatelessWidget {
  const InventoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1),
          ],
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('inventario').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No hay datos disponibles.'));
            }

            final inventoryData = snapshot.data!.docs;

            return DataTable(
              columns: const [
                DataColumn(label: Text("Nombre", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Categoría")),
                DataColumn(label: Text("Existencia")),
                DataColumn(label: Text("Existencia Mínima")),
                DataColumn(label: Text("Precio")),
                DataColumn(label: Text("Acciones")),
              ],
              rows: inventoryData.map((document) {
                final data = document.data() as Map<String, dynamic>;
                return DataRow(
                  cells: [
                    DataCell(Text(data['nombre'] ?? '')),
                    DataCell(Text(data['categoria'] ?? '')),
                    DataCell(Text(data['existencia']?.toString() ?? '')),
                    DataCell(Text(data['existencia_minima']?.toString() ?? '')),
                    DataCell(Text("\$${data['precio']?.toString() ?? ''}")),
                    DataCell(Icon(Icons.more_vert)),
                  ],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}