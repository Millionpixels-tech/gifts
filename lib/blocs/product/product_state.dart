part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class LoadingProductState extends ProductState {}

class SuccessProductRetrievalState extends ProductState {
  final List<dynamic> products;

  SuccessProductRetrievalState(this.products);
}

class ErrorProductState extends ProductState {
  final String message;

  ErrorProductState(this.message);
}
