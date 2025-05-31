import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/form_field/form_field_model.dart';
import 'package:found_you_app/ui/common_widgets/neo_button.dart';
import 'package:found_you_app/ui/common_widgets/neo_date_Input.dart';
import 'package:found_you_app/ui/common_widgets/neo_radio_group.dart';
import 'package:found_you_app/ui/common_widgets/neo_select.dart';
import 'package:found_you_app/ui/common_widgets/neo_text_field.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FormFieldWidget extends StatelessWidget {
  final FormFieldModel formField;
  final ValueChanged<dynamic> onChanged;
  final dynamic value;

  const FormFieldWidget({Key? key, required this.formField, required this.onChanged, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (formField.type) {
      case FormFieldType.textfield:
        return NeoTextField(
          onChanged: onChanged,
          label: formField.label,
          keyboardType: TextInputType.name,
          maxLines: 1,
        );

      case FormFieldType.radio:
        // return Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(formField.label, style: Theme.of(context).textTheme.titleMedium),
        //       ...formField.options.map(
        //         (option) => RadioListTile(
        //           title: Text(option.name),
        //           value: option.value,
        //           groupValue: value,
        //           onChanged: onChanged,
        //         ),
        //       ),
        //     ],
        //   ),
        // );
        return NeoRadioGroup(
          option1: formField.options[0].name,
          option2: formField.options[1].name,
          selectedIndex: value,
          onChanged: onChanged,
          opt1Color: NeoColors.springGreen,
          opt2Color: NeoColors.springGreen,
        );

      case FormFieldType.date:
        // return Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: GestureDetector(
        //     onTap: () async {
        //       final picked = await showDatePicker(
        //         context: context,
        //         initialDate: value ?? DateTime.now(),
        //         firstDate: DateTime(1900),
        //         lastDate: DateTime.now(),
        //       );
        //       if (picked != null) onChanged(picked);
        //     },
        //     child: InputDecorator(
        //       decoration: InputDecoration(
        //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        //       ),
        //       child: Text(
        //         value != null
        //             ? DateFormat.yMd(Localizations.localeOf(context).toLanguageTag()).format(value as DateTime)
        //             : 'Wybierz datę',
        //       ),
        //     ),
        //   ),
        // );
        // case FormFieldType.dobInput:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: NeoDateInput(onChanged: (str) => print('DOB digits: \$str')),
        );

      case FormFieldType.textarea:
        return NeoTextField(onChanged: onChanged, label: '', keyboardType: TextInputType.name, maxLines: 5);

      // case FormFieldType.photo:
      //   return GestureDetector(
      //     onTap: () async {
      //       final picker = ImagePicker();
      //       final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
      //       if (picked == null) return;
      //
      //       // 1) Read the file bytes
      //       final bytes = await File(picked.path).readAsBytes();
      //
      //       // 2) Convert to Base64
      //       final b64   = base64Encode(bytes);
      //
      //       // 3) Pass the Base64‐string to your VM
      //       onChanged(b64);
      //     },
      //     child: value == null ? NeoButton(
      //       onPressed: () async {
      //         final picker = ImagePicker();
      //         final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
      //         if (picked == null) return;
      //
      //         // 1) Read the file bytes
      //         final bytes = await File(picked.path).readAsBytes();
      //
      //         // 2) Convert to Base64
      //         final b64   = base64Encode(bytes);
      //
      //         // 3) Pass the Base64‐string to your VM
      //         onChanged(b64);
      //       },
      //       text: 'Wybierz zdjęcie',
      //       backgroundColor: Colors.white,
      //       borderRadius: BorderRadius.circular(0),
      //       width: 184,
      //     ): Container(),
      //   );
      case FormFieldType.photo:
        return GestureDetector(
          onTap: () async {
            final picker = ImagePicker();
            final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
            if (picked == null) return;
            final bytes = await File(picked.path).readAsBytes();
            final b64 = base64Encode(bytes);
            onChanged(b64);
          },
          child:
              value == null
                  // jeszcze nie wybrano zdjęcia
                  ? NeoButton(
                    onPressed: () async {
                      final picker = ImagePicker();
                      final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
                      if (picked == null) return;
                      final bytes = await File(picked.path).readAsBytes();
                      final b64 = base64Encode(bytes);
                      onChanged(b64);
                    },
                    text: 'Wybierz zdjęcie',
                    backgroundColor: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                    width: 184,
                  )
                  : Container(
                    width: 164,
                    height: 164,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 4),
                      boxShadow: [BoxShadow(color: Colors.black, offset: Offset(3, 3), blurRadius: 0)],
                    ),
                    child: ClipOval(
                      child: Image.memory(
                        base64Decode(value),
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
        );

      // case FormFieldType.select:
      //   return Expanded(
      //     child: Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: SingleChildScrollView(
      //         scrollDirection: Axis.vertical,
      //         child: Wrap(
      //           direction: Axis.horizontal,
      //           spacing: 8,
      //           runSpacing: 8,
      //           children:
      //               formField.options.map((option) {
      //                 final bool isSelected = (value as List<dynamic>?)?.contains(option.value) ?? false;
      //                 return ChoiceChip(
      //                   label: Text(option.name),
      //                   selected: isSelected,
      //                   onSelected: (selected) {
      //                     final currentValues = List<dynamic>.from(value ?? []);
      //                     if (selected) {
      //                       if (currentValues.length < 5) {
      //                         currentValues.add(option.value);
      //                       } else {
      //                         ScaffoldMessenger.of(context).showSnackBar(
      //                           SnackBar(
      //                             content: Center(child: Text('Możesz wybrać maksymalnie 5 opcji.')),
      //                             duration: const Duration(seconds: 1),
      //                           ),
      //                         );
      //                       }
      //                     } else {
      //                       currentValues.remove(option.value);
      //                     }
      //                     onChanged(currentValues);
      //                   },
      //                 );
      //               }).toList(),
      //         ),
      //       ),
      //     ),
      //   );

      case FormFieldType.select:
        return Expanded(
          child: SingleChildScrollView(
            child: NeoSelect(
              options: formField.options.map((o) => NeoSelectOption(value: o.value, label: o.name, selectedColor:
              NeoColors.randomRegisterColors()))
                  .toList(),
              selectedValues: value,
              onChanged: (newSelection) => onChanged(newSelection),
            ),
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }
}
