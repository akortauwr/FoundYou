import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/form_field/form_field_model.dart';
import 'package:found_you_app/ui/common_widgets/neo_button.dart';
import 'package:found_you_app/ui/common_widgets/neo_date_Input.dart';
import 'package:found_you_app/ui/common_widgets/neo_radio_group.dart';
import 'package:found_you_app/ui/common_widgets/neo_select.dart';
import 'package:found_you_app/ui/common_widgets/neo_text_field.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';
import 'package:image_picker/image_picker.dart';


// Krok 1: Zmień definicję widgetu na StatefulWidget
class FormFieldWidget extends StatefulWidget {
  final FormFieldModel formField;
  final ValueChanged<dynamic> onChanged;
  final dynamic value;

  const FormFieldWidget({
    Key? key,
    required this.formField,
    required this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  _FormFieldWidgetState createState() => _FormFieldWidgetState();
}

// Krok 2: Utwórz klasę State
class _FormFieldWidgetState extends State<FormFieldWidget> {
  // Kontroler będzie istniał tylko dla pól tekstowych.
  TextEditingController? _textController;

  @override
  void initState() {
    super.initState();
    // Tworzymy kontroler tylko jeśli widget jest dla pola tekstowego.
    if (widget.formField.type == FormFieldType.textfield || widget.formField.type == FormFieldType.textarea) {
      _textController = TextEditingController(text: widget.value as String?);
    }
  }

  @override
  void didUpdateWidget(FormFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Ta metoda jest kluczowa. Jeśli dane w ViewModelu zmienią się z zewnątrz
    // (np. po resecie formularza), musimy zaktualizować tekst w naszym kontrolerze.
    // Sprawdzamy, czy nowa wartość jest inna niż obecna w kontrolerze,
    // aby uniknąć przeskakiwania kursora podczas pisania.
    if (_textController != null && widget.value != _textController!.text) {
      _textController!.text = widget.value as String? ?? '';
    }
  }


  @override
  void dispose() {
    // BARDZO WAŻNE: Zwalniamy zasoby kontrolera, aby uniknąć wycieków pamięci.
    _textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.formField.type) {
      case FormFieldType.textfield:
      case FormFieldType.textarea:
      // Krok 3: Przekaż kontroler do NeoTextField
        return NeoTextField(
          controller: _textController, // Używamy naszego kontrolera
          onChanged: widget.onChanged,   // Callback wciąż aktualizuje ViewModel
          label: widget.formField.label,
          keyboardType: TextInputType.name,
          maxLines: widget.formField.type == FormFieldType.textarea ? 5 : 1,
        );

      case FormFieldType.radio:
      // Pozostałe widgety nie wymagają zmian, używają `widget.value` bezpośrednio
        return NeoRadioGroup(
          option1: widget.formField.options[0].name,
          option2: widget.formField.options[1].name,
          selectedIndex: widget.value, // Przekazujemy wartość bezpośrednio
          onChanged: widget.onChanged,
          opt1Color: NeoColors.springGreen,
          opt2Color: NeoColors.springGreen,
        );

      case FormFieldType.date:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: NeoDateInput(onChanged: widget.onChanged, initialValue: widget.value,),
        );

      case FormFieldType.photo:
        return GestureDetector(
          onTap: () async {
            final picker = ImagePicker();
            final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
            if (picked == null) return;
            final bytes = await File(picked.path).readAsBytes();
            final b64 = base64Encode(bytes);
            widget.onChanged(b64);
          },
          child:
          widget.value == null
              ? NeoButton(
            onPressed: () async {
              final picker = ImagePicker();
              final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
              if (picked == null) return;
              final bytes = await File(picked.path).readAsBytes();
              final b64 = base64Encode(bytes);
              widget.onChanged(b64);
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
                base64Decode(widget.value),
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        );

      case FormFieldType.select:
        return Expanded(
          child: SingleChildScrollView(
            child: NeoSelect(
              options: widget.formField.options.map((o) => NeoSelectOption(value: o.value, label: o.name, selectedColor:
              NeoColors.randomRegisterColors()))
                  .toList(),
              selectedValues: widget.value,
              onChanged: (newSelection) => widget.onChanged(newSelection),
            ),
          ),
        );
    }
  }
}