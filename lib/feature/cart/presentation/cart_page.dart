import 'package:electronic_store/core/theme/app_styles.dart';
import 'package:electronic_store/core/widget/custom_button.dart';
import 'package:electronic_store/feature/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<CartCubit>(context).clearCart();
            },
            icon: const Icon(Icons.cleaning_services_outlined),
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CartSuccess) {
            if (state.items.isEmpty) {
              return Center(child: Text("Your cart is empty"));
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return ListTile(
                          leading: Image.network(
                            item.image,
                            width: 50,
                            height: 50,
                          ),
                          title: Text(
                            item.name,
                            style: AppStyles.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item.price} EGP",
                                style: AppStyles.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Available: ${item.availableQuantity}",
                                style: AppStyles.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<CartCubit>(
                                    context,
                                  ).updateQuantity(
                                    cartItemId: item.id,
                                    quantity: item.cartQuantity - 1,
                                  );
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              Text(item.cartQuantity.toString()),
                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<CartCubit>(
                                    context,
                                  ).updateQuantity(
                                    cartItemId: item.id,
                                    quantity: item.cartQuantity + 1,
                                  );
                                },
                                icon: const Icon(Icons.add),
                              ),
                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<CartCubit>(
                                    context,
                                  ).removeFromCart(item.id);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: state.items.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  CustomButton(
                    bName:
                        "Total Price: ${state.totalPrice.toStringAsFixed(3)} EGP",
                    onPressed: () {},
                  ),
                ],
              ),
            );
          }
          if (state is CartError) {
            return Center(child: Text(state.message));
          }
          return SizedBox();
        },
      ),
    );
  }
}
