import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'application/services/service_locator.dart';
import 'application/providers/app_state_provider.dart';
import 'application/providers/theme_provider.dart';
import 'presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await initServiceLocator();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => locator<AppStateProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(locator()),
        ),
      ],
      child: const OpenFundApp(),
    ),
  );
}