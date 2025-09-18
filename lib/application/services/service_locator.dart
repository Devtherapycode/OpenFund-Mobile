import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../core/network/api_client.dart';
import '../../core/network/network_info.dart';
import '../providers/app_state_provider.dart';

final GetIt locator = GetIt.instance;

/// Initialize service locator
Future<void> initServiceLocator() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => http.Client());
  
  // Core
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(),
  );
  
  locator.registerLazySingleton<ApiClient>(
    () => ApiClient(
      baseUrl: const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'https://api.openfund.com',
      ),
      httpClient: locator(),
    ),
  );
  
  // Application
  locator.registerLazySingleton<AppStateProvider>(
    () => AppStateProvider(),
  );
  
  // Data sources
  _registerDataSources();
  
  // Repositories
  _registerRepositories();
  
  // Use cases
  _registerUseCases();
}

void _registerDataSources() {
  // Register remote data sources here
}

void _registerRepositories() {
  // Register repositories here
}

void _registerUseCases() {
  // Register use cases here
}