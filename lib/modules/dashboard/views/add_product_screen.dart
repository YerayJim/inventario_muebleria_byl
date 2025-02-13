import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddInventoryScreen extends StatefulWidget {
  const AddInventoryScreen({super.key});

  @override
  _AddInventoryScreenState createState() => _AddInventoryScreenState();
}

class _AddInventoryScreenState extends State<AddInventoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _existenciaController = TextEditingController();
  final TextEditingController _existenciaMinimaController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  Future<void> _addInventory() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('inventario').add({
          'nombre': _nombreController.text,
          'categoria': _categoriaController.text,
          'existencia': int.parse(_existenciaController.text),
          'existencia_minima': int.parse(_existenciaMinimaController.text),
          'precio': double.parse(_precioController.text),
        });
        Navigator.pop(context); // Cierra la pantalla después de guardar
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar al Inventario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre del Producto'),
                validator: (value) => value!.isEmpty ? 'Ingresa un nombre' : null,
              ),
              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(labelText: 'Categoría'),
                validator: (value) => value!.isEmpty ? 'Ingresa una categoría' : null,
              ),
              TextFormField(
                controller: _existenciaController,
                decoration: const InputDecoration(labelText: 'Existencia Actual'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Ingresa la existencia';
                  if (int.tryParse(value) == null) return 'Valor inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: _existenciaMinimaController,
                decoration: const InputDecoration(labelText: 'Existencia Mínima'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Ingresa el mínimo';
                  if (int.tryParse(value) == null) return 'Valor inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: _precioController,
                decoration: const InputDecoration(labelText: 'Precio Unitario'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Ingresa el precio';
                  if (double.tryParse(value) == null) return 'Valor inválido';
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _addInventory,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Guardar en Inventario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}