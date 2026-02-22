import 'package:electronic_store/core/theme/app_colors.dart';
import 'package:electronic_store/core/theme/app_styles.dart';
import 'package:electronic_store/feature/cart/cubit/cart_cubit.dart';
import 'package:electronic_store/feature/home/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomProductCard extends StatelessWidget {
  final ProductModel? product;
  const CustomProductCard({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 180,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(child: Image.network(product!.image, height: 80, width: 80)),
          Text(product!.name, style: AppStyles.bodyLarge),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${product!.price} EGP", style: AppStyles.bodyLarge),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<CartCubit>(context).addToCart(product!.id);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
