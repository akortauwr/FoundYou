import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

class SingleDigitTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    final lastChar = newValue.text.characters.last;
    return TextEditingValue(text: lastChar, selection: const TextSelection.collapsed(offset: 1));
  }
}

class NeoDateInput extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? initialValue;
  final String? errorText;

  const NeoDateInput({super.key, required this.onChanged, this.initialValue, this.errorText});

  @override
  State<NeoDateInput> createState() => _NeoDateInputState();
}

class _NeoDateInputState extends State<NeoDateInput> {
  final _controllers = List.generate(8, (_) => TextEditingController());
  final _fieldNodes = List.generate(8, (_) => FocusNode());
  final _keyListenerNodes = List.generate(8, (_) => FocusNode());
  final _bgColors = List<Color?>.filled(8, null);

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      final initial = widget.initialValue!.padRight(8);
      for (int i = 0; i < 8; i++) {
        _controllers[i].text = initial[i];
      }
    }

    for (int i = 0; i < 8; i++) {
      _fieldNodes[i].addListener(() {
        setState(() {
          _bgColors[i] = _fieldNodes[i].hasFocus ? NeoColors.randomPastel() : null;
        });
      });
      _controllers[i].addListener(() {
        widget.onChanged(_controllers.map((c) => c.text).join());
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _fieldNodes) {
      f.dispose();
    }
    for (final k in _keyListenerNodes) {
      k.dispose();
    }
    super.dispose();
  }

  Widget _buildBox(int index, String label) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final focused = _fieldNodes[index].hasFocus;
    final content = _controllers[index].text.isNotEmpty ? _controllers[index].text : (!focused ? label : '');
    final offset = focused ? const Offset(0.5, 0.5) : const Offset(3, 3);

    final borderColor = hasError ? Colors.red : Colors.black;
    final shadowColor = hasError ? Colors.red.withValues(alpha: 0.7) : Colors.black;

    return GestureDetector(
      onTap: () => _fieldNodes[index].requestFocus(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          color: _bgColors[index] ?? Colors.white,
          border: Border.all(color: borderColor, width: 3),
          boxShadow: [BoxShadow(color: shadowColor, offset: offset)],
        ),
        alignment: Alignment.center,
        child: KeyboardListener(
          focusNode: _keyListenerNodes[index],
          onKeyEvent: (event) {
            if (event is KeyDownEvent) {
              final key = event.logicalKey.keyLabel;
              if (RegExp(r'^[0-9]$').hasMatch(key)) {
                _controllers[index].text = key;
                _controllers[index].selection = const TextSelection.collapsed(offset: 1);
                widget.onChanged(_controllers.map((c) => c.text).join());

                if (index < 7) {
                  _fieldNodes[index + 1].requestFocus();
                } else {
                  FocusScope.of(context).unfocus();
                }
              }
            }
          },
          child: TextField(
            controller: _controllers[index],
            focusNode: _fieldNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            maxLength: 1,
            showCursor: false,
            cursorColor: Colors.transparent,
            decoration: InputDecoration(
              hintText: content,
              border: InputBorder.none,
              counterText: '',
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, SingleDigitTextInputFormatter()],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBox(0, 'D'),
            _buildBox(1, 'D'),
            Container(
              width: 16,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),

              color: hasError ? Colors.red : Colors.black,
            ),
            _buildBox(2, 'M'),
            _buildBox(3, 'M'),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildBox(4, 'Y'), _buildBox(5, 'Y'), _buildBox(6, 'Y'), _buildBox(7, 'Y')],
        ),

        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}