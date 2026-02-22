import 'package:bloc/bloc.dart';
import 'package:electronic_store/feature/cart/data/model/cart_item_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> getOrCreateCart(String userId) async {
    final existingCart = await supabase
        .from("carts")
        .select()
        .eq("user_id", userId)
        .limit(1)
        .maybeSingle();

    if (existingCart != null) return existingCart;

    return await supabase
        .from("carts")
        .insert({"user_id": userId})
        .select()
        .single();
  }

  double calcTotalPrice(List<CartItemModel> items) {
    return items.fold(
      0.0,
      (sum, item) => sum + (item.price * item.cartQuantity),
    );
  }

  Future<void> getCartItems() async {
    emit(CartLoading());

    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        emit(CartError(message: "User not logged in"));
        return;
      }

      final cart = await getOrCreateCart(user.id);

      final response = await supabase
          .from("cart_items")
          .select('''
            id,
            quantity,
            products (
              id,
              name,
              price,
              image,
              quantity
            )
          ''')
          .eq("cart_id", cart['id']);

      final items = (response as List)
          .map((item) => CartItemModel.fromJson(item))
          .toList();

      emit(CartSuccess(items: items, totalPrice: calcTotalPrice(items)));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> addToCart(int productId) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        emit(CartError(message: "User not logged in"));
        return;
      }

      final cart = await getOrCreateCart(user.id);

      final existingItem = await supabase
          .from("cart_items")
          .select('id, quantity')
          .eq("cart_id", cart['id'])
          .eq("product_id", productId)
          .limit(1)
          .maybeSingle();

      final product = await supabase
          .from("products")
          .select('quantity')
          .eq("id", productId)
          .single();

      final availableQuantity = product['quantity'] as int;

      if (existingItem != null) {
        if (existingItem['quantity'] >= availableQuantity) return;

        await supabase
            .from("cart_items")
            .update({"quantity": existingItem['quantity'] + 1})
            .eq("id", existingItem['id']);
      } else {
        if (availableQuantity <= 0) return;

        await supabase.from("cart_items").insert({
          "cart_id": cart['id'],
          "product_id": productId,
          "quantity": 1,
        });
      }

      await getCartItems();
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> updateQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    if (state is! CartSuccess) return;

    final currentState = state as CartSuccess;

    final item = currentState.items.firstWhere((item) => item.id == cartItemId);

    if (quantity > item.availableQuantity) return;

    if (quantity <= 0) {
      await removeFromCart(cartItemId); // ✅ صح
      return;
    }

    final updatedItems = currentState.items.map((item) {
      if (item.id == cartItemId) {
        return item.copyWith(cartQuantity: quantity);
      }
      return item;
    }).toList();

    emit(
      CartSuccess(
        items: updatedItems,
        totalPrice: calcTotalPrice(updatedItems),
      ),
    );

    await supabase
        .from("cart_items")
        .update({"quantity": quantity})
        .eq("id", cartItemId);
  }

  Future<void> removeFromCart(String cartItemId) async {
    if (state is! CartSuccess) return;

    final currentState = state as CartSuccess;

    final updatedItems = currentState.items
        .where((item) => item.id != cartItemId)
        .toList();

    emit(
      CartSuccess(
        items: updatedItems,
        totalPrice: calcTotalPrice(updatedItems),
      ),
    );

    await supabase.from("cart_items").delete().eq("id", cartItemId);
  }

  Future<void> clearCart() async {
    if (state is! CartSuccess) return;

    emit(CartSuccess(items: [], totalPrice: 0.0));

    final user = supabase.auth.currentUser;
    if (user == null) return;

    final cart = await getOrCreateCart(user.id);

    await supabase.from("cart_items").delete().eq("cart_id", cart['id']);
  }
}
