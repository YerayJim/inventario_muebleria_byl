import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final VoidCallback onAddProduct;

  const SearchBarWidget({super.key, required this.onAddProduct});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white, // Ahora coincide con la tabla
          borderRadius: BorderRadius.circular(8.0), // Ajustado al estilo de la tabla
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Barra de búsqueda con altura igualada al botón
            Expanded(
              child: SizedBox(
                height: 40, // Altura igual a la del botón
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Busca tu Producto",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white, // Fondo ahora coincide con la tabla
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey), // Mantiene el borde
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Botón "Agregar Producto"
            ElevatedButton.icon(
              onPressed: onAddProduct,
              icon: const Icon(Icons.add),
              label: const Text("Agregar Producto"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                minimumSize: const Size(0, 48), // Altura fija para que coincida
              ),
            ),
          ],
        ),
      ),
    );
  }
}
