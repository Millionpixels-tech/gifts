import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      try {
        // Get the collection from Firestore (assuming products are stored in a 'products' collection)
        final QuerySnapshot snapshot =
            await FirebaseFirestore.instance.collection('products').get();

        // Extract data from snapshot
        final List<dynamic> products = snapshot.docs
            .map((doc) => doc.data()) // Get the data from each document
            .toList();
        emit(SuccessProductRetrievalState(products));
      } catch (e) {
        emit(ErrorProductState("An error occurred: $e"));
      }
    });
  }
}
