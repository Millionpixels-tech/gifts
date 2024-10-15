// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterEvent>(
      (event, emit) async {
        emit(LoadingState());
        try {
          const storage = FlutterSecureStorage();
          // Use Firebase Auth to register user
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );

          // Store tokens or userId if needed
          await storage.write(key: 'userId', value: userCredential.user!.uid);

          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            "email": event.email,
            "is_active": true,
            "name": "", // Assuming you have userName in RegisterEvent
            "address_line_1": "", // Optional: add default values if needed
            "address_line_2": "",
            "city": "",
            "district": "",
            "postal_code": "",
            "contact_number": "",
            "created_at": Timestamp.now(), // Set the creation timestamp
            "updated_at": Timestamp.now(), // Set the updated timestamp
          });

          emit(SuccessRegisterState());
        } catch (error) {
          emit(AuthErrorState(error.toString()));
        }
      },
    );

    on<LoginEvent>(
      (event, emit) async {
        emit(LoadingState());
        try {
          const storage = FlutterSecureStorage();
          // Use Firebase Auth to sign in user
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );

          await storage.write(key: 'userId', value: userCredential.user!.uid);

          emit(SuccessLoginState());
        } catch (error) {
          emit(AuthErrorState(error.toString()));
        }
      },
    );

    on<LogoutEvent>(
      (event, emit) async {
        try {
          const FlutterSecureStorage secureStorage = FlutterSecureStorage();
          await secureStorage.delete(key: 'userId');
          emit(SuccessLogoutState());
        } catch (error) {
          emit(AuthErrorState(error.toString()));
        }
      },
    );

    on<UpdateAddressEvent>(
      (event, emit) async {
        try {
          const storage = FlutterSecureStorage();
          final userId = await storage.read(key: 'userId');
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({
            "address_line_1": event.adressLine1,
            "address_line_2": event.adressLine2,
            "city": event.city,
            "district": event.district,
            "postal_code": event.postalCode,
            "contact_number": event.contactNumber,
            "name": event.userName,
          });

          emit(SuccessAddressUpdateState());
        } catch (error) {
          emit(AuthErrorState(error.toString()));
        }
      },
    );

    on<UpdateNameEvent>(
      (event, emit) async {
        try {
          const storage = FlutterSecureStorage();
          final userId = await storage.read(key: 'userId');
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({
            "name": event.name,
          });

          emit(SuccessNameUpdateState());
        } catch (error) {
          emit(AuthErrorState(error.toString()));
        }
      },
    );
  }
}
