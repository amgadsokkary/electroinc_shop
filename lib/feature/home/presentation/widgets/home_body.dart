import 'package:electronic_store/core/theme/app_colors.dart';
import 'package:electronic_store/core/theme/app_images.dart';
import 'package:electronic_store/core/theme/app_styles.dart';
import 'package:electronic_store/core/widget/custom_text_form_field.dart';
import 'package:electronic_store/feature/home/cubit/product/product_cubit.dart';
import 'package:electronic_store/feature/home/presentation/widgets/custom_groceries_cart.dart';
import 'package:electronic_store/feature/home/presentation/widgets/head_title.dart';
import 'package:electronic_store/feature/home/presentation/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 10,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Image.asset(AppImages.logo, height: 100, width: 100),
            ),
          ),
          Text(
            "Egypt, Cairo",
            style: AppStyles.headlineLarge.copyWith(color: Colors.white),
          ),
          CustomTextFormField(
            icon: Icons.search,
            controller: TextEditingController(),
            hintText: "Search",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            fillColor: AppColors.primary,
            filled: true,
          ),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.banner),
                fit: BoxFit.fill,
              ),
            ),
          ),
          HeadTitle(title: "Exclusive Offer", onPressed: () {}),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProductSuccess) {
                return ProductList(products: state.products);
              } else if (state is ProductError) {
                return Center(child: Text(state.message));
              }
              return SizedBox();
            },
          ),
          HeadTitle(title: "Groceries", onPressed: () {}),
          CustomGroceriesCart(
            image: "https://i.ibb.co/sdPwW0kd/X8.png",
            name: "X8",
            color: Colors.red,
          ),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProductSuccess) {
                return ProductList(products: state.products);
              } else if (state is ProductError) {
                return Center(child: Text(state.message));
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
