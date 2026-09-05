
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/services/product_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final productServiceProvider = Provider<ProductService>((ref) {
  return ProductService();
});

final categoriesProvider = FutureProvider<List<Category>>((ref){
  final service = ref.watch(productServiceProvider);
  return service.getCategory();
}

);

class CategoriaSeleccionada extends Notifier<String?>{
  @override
  String? build() => null;
  void seleccionR(String? slug){
    state = (state==slug) ? null : slug;
  }
}

final categoriesSeleccionadaProvider = NotifierProvider<CategoriaSeleccionada, String?>(CategoriaSeleccionada.new);

final productProvider = FutureProvider<List<Product>>((ref){
  final service = ref.watch(productServiceProvider);
  final slug = ref.watch(categoriesSeleccionadaProvider);
  return slug == null ? service.getProducts() : service.getProductsByCategory(slug);
});

final productByIdProvider = FutureProvider.family<Product, int>((ref, id){
  final service = ref.watch(productServiceProvider);
  return service.getProductById(id);
});