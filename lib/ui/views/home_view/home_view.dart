import 'package:blank_project/services/api_services/converter_service.dart';
import 'package:blank_project/ui/shared/components/_components.dart';
import 'package:blank_project/ui/shared/constants/spacing.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(service: ConverterService()),
      builder: (context, viewModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('HomeView'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              AppTextField(
                label: 'Amount',
                keyboardType: TextInputType.number,
                onChanged: viewModel.updateAmount,
              ),
              Spacing.vertRegular(),
              AppButton(
                label: 'Convert',
                onPressed: viewModel.convert,
                isBusy: viewModel.isBusy,
              ),
              Spacing.vertExtraLarge(),
              if (viewModel.converted != null)
                Center(
                  child: Text('Converted: ${viewModel.converted}'),
                ),
            ],
          ),
        );
      },
    );
  }
}
