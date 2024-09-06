import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gifts/controllers/api_client.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterEvent>(
      (event, emit) async {
        try {
          const storage = FlutterSecureStorage();
          final url = Uri.parse(
            '${dotenv.env['API_HOST']}:${dotenv.env['API_PORT']}/api/auth/register',
          );
          final headers = {"Content-type": "application/json"};
          final body =
              jsonEncode({"email": event.email, "password": event.password});

          var response = await http.post(url, headers: headers, body: body);
          var statusCode = response.statusCode;
          if (statusCode == 401) {
            //Should dipslay error message to user
            emit(AuthErrorState("Invalid data provided"));
          } else if (statusCode == 409) {
            emit(AuthErrorState("Email is already registered"));
          } else if (statusCode == 200) {
            var data = jsonDecode(response.body);
            print(data);
            await storage.write(
              key: 'accessToken',
              value: data['accessToken'],
            );
            await storage.write(
              key: 'refreshToken',
              value: data['refreshToken'],
            );
            await storage.write(
              key: 'userId',
              value: data['userId']['id'], // Save the userId
            );
            emit(SuccessRegisterState());
          }
        } catch (error) {
          emit(AuthErrorState(error.toString()));
          print(' error is $error');
        }
      },
    );
    on<LoginEvent>(
      (event, emit) async {
        try {
          const storage = FlutterSecureStorage();
          final url = Uri.parse(
            '${dotenv.env['API_HOST']}:${dotenv.env['API_PORT']}/api/auth/login',
          );
          final headers = {"Content-type": "application/json"};
          final body = jsonEncode(
            {
              "email": event.email,
              "password": event.password,
            },
          );
          var response = await http.post(url, headers: headers, body: body);
          var statusCode = response.statusCode;
          if (statusCode == 401) {
            emit(AuthErrorState(
                'Incorrect email or password, Please try again'));
          } else if (statusCode == 200) {
            var data = jsonDecode(response.body);
            // we need this pront to see access and refresh tokens
            await storage.write(
              key: 'accessToken',
              value: data['accessToken'],
            );
            await storage.write(
              key: 'refreshToken',
              value: data['refreshToken'],
            );
            await storage.write(
              key: 'userId',
              value: data['userId']['id'], // Save the userId
            );
            emit(SuccessLoginState());
          }
        } catch (error) {
          emit(AuthErrorState(error.toString()));
        }
      },
    );
    on<LogoutEvent>(
      (event, emit) async {
        try {
          const FlutterSecureStorage secureStorage = FlutterSecureStorage();
          await secureStorage.delete(key: 'accessToken');
          await secureStorage.delete(key: 'refreshToken');
          emit(SuccessLogoutState());
        } catch (error) {
          emit(AuthErrorState(error.toString()));
        }
      },
    );

    on<UpdateAddressEvent>(
      (event, emit) async {
        final ApiClient apiClient = ApiClient();
        try {
          final response = await apiClient.put("/user/update",
          {
            "address_line_1": event.adressLine1,
            "address_line_2": event.adressLine2,
            "city": event.city,
            "district": event.district,
            "postal_code": event.postalCode,
            "contact_number": event.contactNumber,
          });
          
          var statusCode = response.statusCode;
          print(statusCode);
          if (statusCode == 401) {
            //Should dipslay error message to user
            emit(AuthErrorState("Invalid data provided"));
        
          } else if (statusCode == 200) {
            emit(SuccessAddressUpdateState());
          }
        } catch (error) {
          emit(AuthErrorState(error.toString()));
          print(' error is $error');
        }
      },
    );

    on<UpdateNameEvent>(
      (event, emit) async {
        final ApiClient apiClient = ApiClient();
        try {
          final response = await apiClient.put("/user/update",
          {
            "name": event.name,
          });
          
          var statusCode = response.statusCode;
          print(statusCode);
          if (statusCode == 401) {
            //Should dipslay error message to user
            emit(AuthErrorState("Invalid data provided"));
        
          } else if (statusCode == 200) {
            emit(SuccessNameUpdateState());
          }
        } catch (error) {
          emit(AuthErrorState(error.toString()));
          print(' error is $error');
        }
      },
    );
  }
}
