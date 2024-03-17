import 'package:blank_project/services/core_services/network_service/network_service.dart';

/// interface
abstract class IConverterService {
  /// Dollar to naira conversion
  Future<double> convertCurrency(String amount);

  Future<void> sayHi(String name);
}

/// implmentation
class ConverterService extends IConverterService {
  final _networkService = NetworkService();

  @override
  Future<double> convertCurrency(String amount) async {
    final res = await _networkService.get(
      'https://v6.exchangerate-api.com/v6/70aed6287da9c5369fb3e908/latest/USD',
    );

    final res2 = (res as Map)["conversion_rates"]["EUR"] * double.parse(amount);
    return res2;
  }

  @override
  Future<void> sayHi(String name) async {
    print("Hi $name");
  }
}
