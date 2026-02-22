import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:electronic_store/feature/home/data/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  final supabase = Supabase.instance.client;

  Future<void> getAllProduct() async {
    emit(ProductLoading());
    try {
      final response = await supabase
          .from('products')
          .select()
          .order('created_at', ascending: false);
      final products = response
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList();
      emit(ProductSuccess(products: products));
    } on Exception catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> addProduct({
    required String name,
    required num price,
    required String image,
    required String detail,
    required String category,
    required int quantity,
    required int review,
  }) async {
    emit(ProductLoading());
    try {
      await supabase.from('products').insert({
        'name': name,
        'price': price,
        'image': image,
        'detail': detail,
        'category': category,
        'quantity': quantity,
        'review': review,
      });
      emit(AddProductSuccess(message: "Product Added Successfully"));
      await getAllProduct();
    } on Exception catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
