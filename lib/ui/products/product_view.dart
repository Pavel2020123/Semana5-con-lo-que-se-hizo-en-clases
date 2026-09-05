import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductView extends ConsumerWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listar Productos'),
        actions: [
          IconButton(
            tooltip: Theme.of(context).brightness == Brightness.dark
                ? 'Usar tema claro'
                : 'Usar tema oscuro',
            onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),
      body: Column(children: [Categorias(), ProductosFiltrados()]),
    );
  }
}

class ProductosFiltrados extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Text('Producto #$index');
        },
      ),
    );
  }
}

class Categorias extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.category),
        Icon(Icons.category),
        Icon(Icons.category),
        Icon(Icons.category),
        Icon(Icons.category),
        Icon(Icons.category),
        Icon(Icons.category),
        Icon(Icons.category),
        Icon(Icons.category),
        Icon(Icons.category),
        Icon(Icons.category),
        Icon(Icons.category),
      ],
    );
  }
}
