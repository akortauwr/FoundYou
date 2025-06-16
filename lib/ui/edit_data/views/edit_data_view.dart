import 'package:flutter/material.dart';
import 'package:found_you_app/ui/common_widgets/form_field_widget.dart';
import 'package:found_you_app/ui/common_widgets/neo_app_bar.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/common_widgets/neo_icon_buttons.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';
import 'package:found_you_app/ui/edit_data/view_models/edit_data_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditDataView extends StatefulWidget {
  const EditDataView({super.key});

  @override
  State<EditDataView> createState() => _EditDataViewState();
}

class _EditDataViewState extends State<EditDataView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void nextPage() {
    if (_currentPage < context.read<EditDataViewModel>().fields!.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void previousPage() {
    if (_currentPage == 0) {
      context.pop();
    }
    if (_currentPage > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<EditDataViewModel>();

    return Scaffold(
      appBar: const NeoAppBar(text: 'Edytuj dane'),
      body:
          vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : vm.fields == null || vm.fields!.isEmpty
              ? const Center(child: Text('Błąd ładowania formularza.'))
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
                            physics: const NeverScrollableScrollPhysics(),
                            onPageChanged: (page) => setState(() => _currentPage = page),
                            itemCount: vm.fields!.length,
                            itemBuilder: (context, index) {
                              final field = vm.fields![index];
                              final error = vm.errors[field.name];

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text(
                                      field.label,
                                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  FormFieldWidget(
                                    formField: field,
                                    onChanged: (value) => vm.updateField(field.name, value),
                                    value: vm.getFieldValue(field.name),
                                    errorText: error,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NeoIconButton(
                                onPressed: previousPage,
                                shadowOffset: const Offset(6, 6),
                                child: const Icon(Icons.arrow_back),
                              ),
                              NeoIconButton(
                                onPressed:
                                    _currentPage == vm.fields!.length - 1
                                        ? () async {
                                          if (vm.validate()) {
                                            final success = await vm.updateProfile();
                                            if (!context.mounted) return;
                                            if (success) {
                                              context.pop(true);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: NeoColors.mossGreen,
                                                  content: Text('Dane zaktualizowane pomyślnie!'),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: NeoColors.tomatoRed,
                                                  content: Text(
                                                    'Wystąpił błąd podczas aktualizacji. Spróbuj ponownie.',
                                                  ),
                                                ),
                                              );
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                backgroundColor: NeoColors.amberOrange,
                                                content: Text('Uzupełnij wymagane pola lub popraw błędy!'),
                                              ),
                                            );
                                          }
                                        }
                                        : nextPage,
                                child: Icon(_currentPage == vm.fields!.length - 1 ? Icons.check : Icons.arrow_forward),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}
