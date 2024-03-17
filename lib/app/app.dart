import 'package:blank_project/services/core_services/network_service/i_network_service.dart';
import 'package:blank_project/services/core_services/network_service/network_service.dart';
import 'package:blank_project/ui/views/home_view/home_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    AdaptiveRoute(page: HomeView, initial: true),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),

    /// Core Services
    LazySingleton(classType: NetworkService, asType: INetworkService),

    

    /// Api Services
  ],
  logger: StackedLogger(),
)
class App {}
