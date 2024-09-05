import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gifts/blocs/auth/auth_bloc.dart';
import 'package:gifts/common_widgets/input_text_box_widget.dart';
import 'package:gifts/common_widgets/submit_button_widget.dart';
import 'package:go_router/go_router.dart';

class AddressDetails extends StatefulWidget {
  const AddressDetails({super.key});

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SuccessAddressUpdateState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Address Details Updated Successfully')),
          );
          GoRouter.of(context).pushNamed('trackingpage');
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add your shipping details',
                  style: textTheme.headlineSmall?.copyWith(fontSize: 22),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Provide your details to deliver your prize',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 36,
                ),
                Text(
                  'Street address line 1',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                InputTextbox(
                  hintText: 'No.132/A',
                  controller: addressLine1Controller,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Street address line 2',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                InputTextbox(
                  hintText: 'Araliya Street',
                  controller: addressLine2Controller,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'City',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                InputTextbox(
                  hintText: 'Gampola',
                  controller: cityController,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'District',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                InputTextbox(
                  hintText: 'Kandy',
                  controller: districtController,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Postal Code',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                InputTextbox(
                  hintText: '1234560',
                  controller: postalCodeController,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Contact Number',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                InputTextbox(
                  hintText: '076 1234567',
                  controller: contactNumberController,
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                    child: SubmitButtonWidget(
                  buttonHeight: 56,
                  buttonWidth: 181,
                  text: 'Continue',
                  hasIcon: false,
                  buttonIconUrl: '',
                  onTapFunction: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      UpdateAddressEvent(
                        addressLine1Controller.text,
                        addressLine2Controller.text,
                        cityController.text,
                        districtController.text,
                        postalCodeController.text,
                        contactNumberController.text
                      ),
                    );
                    
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
