import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/form_field/form_field_model.dart';
import 'package:found_you_app/ui/common_widgets/neo_button.dart';
import 'package:found_you_app/ui/common_widgets/neo_date_input.dart';
import 'package:found_you_app/ui/common_widgets/neo_radio_group.dart';
import 'package:found_you_app/ui/common_widgets/neo_select.dart';
import 'package:found_you_app/ui/common_widgets/neo_text_field.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';
import 'package:image_picker/image_picker.dart';

class FormFieldWidget extends StatefulWidget {
  final FormFieldModel formField;
  final ValueChanged<dynamic> onChanged;
  final dynamic value;

  const FormFieldWidget({super.key, required this.formField, required this.onChanged, this.value});

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  TextEditingController? _textController;

  @override
  void initState() {
    super.initState();

    if (widget.formField.type == FormFieldType.textfield || widget.formField.type == FormFieldType.textarea) {
      _textController = TextEditingController(text: widget.value as String?);
    }
  }

  @override
  void didUpdateWidget(FormFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_textController != null && widget.value != _textController!.text) {
      _textController!.text = widget.value as String? ?? '';
    }
  }

  @override
  void dispose() {
    _textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.formField.type) {
      case FormFieldType.textfield:
      case FormFieldType.textarea:
        return NeoTextField(
          controller: _textController,
          onChanged: widget.onChanged,
          label: widget.formField.label,
          keyboardType: TextInputType.name,
          maxLines: widget.formField.type == FormFieldType.textarea ? 5 : 1,
        );

      case FormFieldType.radio:
        return NeoRadioGroup(
          option1: widget.formField.options[0].name,
          option2: widget.formField.options[1].name,
          selectedIndex: widget.value,
          onChanged: widget.onChanged,
          opt1Color: NeoColors.springGreen,
          opt2Color: NeoColors.springGreen,
        );

      case FormFieldType.date:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: NeoDateInput(onChanged: widget.onChanged, initialValue: widget.value),
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
                      boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(3, 3), blurRadius: 0)],
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
              options:
                  widget.formField.options
                      .map(
                        (o) => NeoSelectOption(
                          value: o.value,
                          label: o.name,
                          selectedColor: NeoColors.randomRegisterColors(),
                        ),
                      )
                      .toList(),
              selectedValues: widget.value,
              onChanged: (newSelection) => widget.onChanged(newSelection),
            ),
          ),
        );
    }
  }
}
