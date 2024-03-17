import 'dart:developer';

import 'package:blank_project/models/general/failure.dart';
import 'package:stacked/stacked.dart';

import '../../../services/api_services/converter_service.dart';

class HomeViewModel extends BaseViewModel {
  final IConverterService service;

  HomeViewModel({
    required this.service,
  });

  String amount = '';
  double? converted;

  Future<void> convert() async {
    try {
      setBusy(true);
      converted = await service.convertCurrency(amount);
      await service.sayHi('Sebastine');
      notifyListeners();
    } on IFailure catch (e, s) {
      log(e.toString());
      log(s.toString());
    } finally {
      setBusy(false);
    }
  }

  void updateAmount(String p1) {
    amount = p1;
  }
}
