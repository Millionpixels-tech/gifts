import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:gifts/controllers/api_client.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      final ApiClient apiClient = ApiClient();

      try {
        final response = await apiClient.get("/product/all");

        if (response.statusCode == 200) {
          final List<dynamic> products = jsonDecode(response.body);
          emit(SuccessProductRetrievalState(products));
        } else {
          emit(ErrorProductState("Failed to retrieve products."));
        }
      } catch (e) {
        emit(ErrorProductState("An error occured: $e"));
      }
    });
  }
}
