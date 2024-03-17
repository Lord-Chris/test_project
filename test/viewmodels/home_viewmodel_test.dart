import 'package:blank_project/models/general/failure.dart';
import 'package:blank_project/services/api_services/converter_service.dart';
import 'package:blank_project/ui/views/home_view/home_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConverterService extends Mock implements IConverterService {}

void main() {
  group('HomeViewModel Test -', () {
    group('convert - ', () {
      /// any
      test('Converter Service should be called once', () async {
        /// Arrange
        final service = MockConverterService();
        HomeViewModel viewModel = HomeViewModel(service: service);
        when(() => service.convertCurrency(any()))
            .thenAnswer((_) async => 100000000);
        when(() => service.sayHi(any())).thenAnswer((_) async {});

        /// Act
        viewModel.updateAmount('1000');
        await viewModel.convert();

        /// Assert
        expect(viewModel.converted, 100000000);
        verify(() => service.convertCurrency('1000')).called(1);
        verify(() => service.sayHi('Sebastine')).called(1);
        verifyNoMoreInteractions(service);
      });

      test('should fail', () async {
        /// Arrange
        final service = MockConverterService();
        HomeViewModel viewModel = HomeViewModel(service: service);
        when(() => service.convertCurrency('100'))
            .thenThrow(const InternetFailure());

        // Act
        viewModel.updateAmount('100');
        await viewModel.convert();

        // Assert
        expect(viewModel.converted, null);
      });
    });

    test('updateAmount - test it is called successfully', () {});
  });
}