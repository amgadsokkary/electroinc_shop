part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductModel> products;
  ProductSuccess({required this.products});
}

class AddProductSuccess extends ProductState {
  final String message;
  AddProductSuccess({required this.message});
}

class ProductError extends ProductState {
  final String message;
  ProductError({required this.message});
}
