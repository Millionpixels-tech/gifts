import 'package:flutter/material.dart';
import 'package:gifts/common_widgets/input_text_box_widget.dart';
import 'package:gifts/common_widgets/submit_button_widget.dart';

class AddressDetails extends StatefulWidget {
  const AddressDetails({super.key});

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add your shipping details', style: textTheme.headlineSmall?.copyWith(fontSize: 22),),
            const SizedBox(height: 16,),
            Text('Provide your details to deliver your prize', style: textTheme.titleMedium,),
            const SizedBox(height: 36,),
            Text('Street address line 1', style: textTheme.titleMedium,),
            const SizedBox(height: 8,),
            const InputTextbox(hintText: 'No.132/A',),
            const SizedBox(height: 16,),
            Text('Street address line 2', style: textTheme.titleMedium,),
            const SizedBox(height: 8,),
            const InputTextbox(hintText: 'Araliya Street',),
            const SizedBox(height: 16,),
            Text('City', style: textTheme.titleMedium,),
            const SizedBox(height: 8,),
            const InputTextbox(hintText: 'Gampola',),
            const SizedBox(height: 16,),
            Text('District', style: textTheme.titleMedium,),
            const SizedBox(height: 8,),
            const InputTextbox(hintText: '123456',),
            const SizedBox(height: 16,),
            Text('Postal Code', style: textTheme.titleMedium,),
            const SizedBox(height: 8,),
            const InputTextbox(hintText: 'Kandy',),
            const SizedBox(height: 16,),
            Text('Contact Number', style: textTheme.titleMedium,),
            const SizedBox(height: 8,),
            const InputTextbox(hintText: '076 1234567',),
            const SizedBox(height: 24,),
            const Center(child: SubmitButtonWidget(buttonHeight: 56, buttonWidth: 181, text: 'Continue', hasIcon: false, buttonIconUrl: ''))
          ],
        ),
      ),
      ),
    );
  }
}