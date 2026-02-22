part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<CartItemModel> items;
  final double totalPrice;
  CartSuccess({required this.items, required this.totalPrice});
}

class CartError extends CartState {
  final String message;
  CartError({required this.message});
}
