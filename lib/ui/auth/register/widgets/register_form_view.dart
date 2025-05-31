import 'package:flutter/material.dart';
import 'package:found_you_app/ui/auth/register/view_models/register_form_view_model.dart';
import 'package:found_you_app/ui/common_widgets/form_field_widget.dart';
import 'package:found_you_app/ui/common_widgets/neo_button.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/common_widgets/neo_icon_buttons.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';
import 'package:provider/provider.dart';

class RegisterFormPageView extends StatefulWidget {
  const RegisterFormPageView({Key? key}) : super(key: key);

  @override
  State<RegisterFormPageView> createState() => _RegisterFormPageViewState();
}

class _RegisterFormPageViewState extends State<RegisterFormPageView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  void nextPage() {
    if (_currentPage < context.read<RegisterFormViewModel>().fields!.length - 1) {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RegisterFormViewModel>();

    return Scaffold(
      body:
          vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : vm.fields == null || vm.fields!.isEmpty
              ? const Center(child: Text('Brak pól formularza'))
              : GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).unfocus(),
                child: Center(
                  child: NeoCard(
                    margin: const EdgeInsets.all(24),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    color: NeoColors.softPurple,
                    height: 400,
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            physics: NeverScrollableScrollPhysics(),
                            onPageChanged: (page) => setState(() => _currentPage = page),
                            itemCount: vm.fields!.length,
                            itemBuilder: (context, index) {
                              final field = vm.fields![index];
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    field.label,
                                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  FormFieldWidget(
                                    formField: field,
                                    onChanged: (value) => vm.updateField(field.name, value),
                                    value: vm.getFieldValue(field.name),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NeoIconButton(
                              onPressed: previousPage,
                              child: Icon(Icons.arrow_back),
                              shadowOffset: Offset(6, 6),
                            ),
                            NeoIconButton(
                              onPressed:
                                  _currentPage == vm.fields!.length - 1
                                      ? () {
                                        if (vm.validate()) {
                                          vm.register();
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(SnackBar(content: Text('Uzupełnij wymagane pola!')));
                                        }
                                      }
                                      : nextPage,
                              child: Icon(_currentPage == vm.fields!.length - 1 ? Icons.check : Icons.arrow_forward),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}
