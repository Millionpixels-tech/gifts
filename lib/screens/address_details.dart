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
      body: Padding(padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add your shipping details', style: textTheme.headlineSmall?.copyWith(fontSize: 22),),
            SizedBox(height: 16,),
            Text('Provide your details to deliver your prize', style: textTheme.titleMedium,),
            SizedBox(height: 36,),
            Text('Street address line 1', style: textTheme.titleMedium,),
            SizedBox(height: 8,),
            InputTextbox(hintText: 'No.132/A',),
            SizedBox(height: 16,),
            Text('Street address line 2', style: textTheme.titleMedium,),
            SizedBox(height: 8,),
            InputTextbox(hintText: 'Araliya Street',),
            SizedBox(height: 16,),
            Text('City', style: textTheme.titleMedium,),
            SizedBox(height: 8,),
            InputTextbox(hintText: 'Gampola',),
            SizedBox(height: 16,),
            Text('District', style: textTheme.titleMedium,),
            SizedBox(height: 8,),
            InputTextbox(hintText: '123456',),
            SizedBox(height: 16,),
            Text('Postal Code', style: textTheme.titleMedium,),
            SizedBox(height: 8,),
            InputTextbox(hintText: 'Kandy',),
            SizedBox(height: 16,),
            Text('Contact Number', style: textTheme.titleMedium,),
            SizedBox(height: 8,),
            InputTextbox(hintText: '076 1234567',),
            SizedBox(height: 24,),
            SubmitButtonWidget(buttonHeight: 56, buttonWidth: 181, text: 'Continue', hasIcon: false, buttonIconUrl: '')
          ],
        ),
      ),
      ),
    );
  }
}