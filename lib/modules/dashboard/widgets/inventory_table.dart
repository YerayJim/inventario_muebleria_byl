import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_inventory_screen.dart'; // Asegúrate de crear este archivo

class InventoryTable extends StatelessWidget {
  const InventoryTable({super.key});

  Future<void> _deleteProduct(BuildContext context, String documentId) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Estás seguro de eliminar este producto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm ?? false) {
      try {
        await FirebaseFirestore.instance
            .collection('inventario')
            .doc(documentId)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto eliminado correctamente')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al eliminar: $e')),
        );
      }
    }
  }

  void _showEditDialog(BuildContext context, Map<String, dynamic> data, String documentId) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: EditInventoryScreen(
            existingData: data,
            documentId: documentId,
          ),
        ),
      ),
    );
  }

  void _addExistDialog(BuildContext context, Map<String, dynamic> data, String documentId){
    final _existenciaController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Agregar Existencia',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _existenciaController,
                  decoration: InputDecoration(
                    labelText: 'Cantidad a agregar',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.grey[200],
                    suffixText: 'unidades',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value == null || value.isEmpty) return 'Campo requerido';
                    if(int.tryParse(value) == null) return 'Numero inválido';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (int.tryParse(_existenciaController.text) != null){
                          try {
                            await FirebaseFirestore.instance
                            .collection('inventario')
                            .doc(documentId)
                            .update({
                              'existencia' : FieldValue.increment(
                                int.parse(_existenciaController.text),
                              )
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Existencia actualizada'),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Ingresa una cantidad valida'),
                            )
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
    
                      ), child: Text("Agregar"),
                    )
                    
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }

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
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No hay datos disponibles.'));
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
                    DataCell(Text(data['nombre']?.toString() ?? '')),
                    DataCell(Text(data['categoria']?.toString() ?? '')),
                    DataCell(Text(data['existencia']?.toString() ?? '')),
                    DataCell(Text(data['existencia_minima']?.toString() ?? '')),
                    DataCell(Text("\$${double.tryParse(data['precio']?.toString() ?? '0')?.toStringAsFixed(2) ?? '0.00'}",)),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteProduct(context, document.id),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showEditDialog(context, data, document.id),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.green),
                            onPressed: () => _addExistDialog(context, data, document.id),
                          )
                        ],
                      ),
                    ),
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