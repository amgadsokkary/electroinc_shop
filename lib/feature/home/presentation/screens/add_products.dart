import 'package:electronic_store/core/widget/custom_button.dart';
import 'package:electronic_store/core/widget/custom_text_form_field.dart';
import 'package:electronic_store/feature/home/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProducts extends StatelessWidget {
  final productName = TextEditingController();
  final productImage = TextEditingController();
  final productCategory = TextEditingController();
  final productPrice = TextEditingController();
  final productQuantity = TextEditingController();
  final productDetails = TextEditingController();
  final productReview = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AddProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: BlocConsumer<ProductCubit, ProductState>(
            listener: (context, state) {
              if (state is AddProductSuccess) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is ProductError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return Column(
                spacing: 15,
                children: [
                  CustomTextFormField(
                    controller: productName,
                    labelText: "Product Name",
                    hintText: "Product Name",
                    icon: Icons.shopping_cart,
                  ),
                  CustomTextFormField(
                    controller: productImage,
                    labelText: "Product Image",
                    hintText: "Product Image",
                    icon: Icons.image,
                  ),
                  CustomTextFormField(
                    controller: productCategory,
                    labelText: "Product Category",
                    hintText: "Product Category",
                    icon: Icons.category,
                  ),
                  CustomTextFormField(
                    controller: productPrice,
                    labelText: "Product Price",
                    hintText: "Product Price",
                    icon: Icons.price_change,
                  ),
                  CustomTextFormField(
                    controller: productQuantity,
                    labelText: "Product Quantity",
                    hintText: "Product Quantity",
                    icon: Icons.numbers,
                  ),
                  CustomTextFormField(
                    controller: productDetails,
                    labelText: "Product Details",
                    hintText: "Product Details",
                    icon: Icons.details,
                  ),
                  CustomTextFormField(
                    controller: productReview,
                    labelText: "Product Review",
                    hintText: "Product Review",
                    icon: Icons.reviews,
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: state is ProductLoading
                        ? CircularProgressIndicator()
                        : CustomButton(
                            bName: "Add Product",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<ProductCubit>(
                                  context,
                                ).addProduct(
                                  name: productName.text,
                                  detail: productDetails.text,
                                  price: double.parse(productPrice.text),
                                  image: productImage.text,
                                  category: productCategory.text,
                                  quantity: int.parse(productQuantity.text),
                                  review: int.parse(productReview.text),
                                );
                              }
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
