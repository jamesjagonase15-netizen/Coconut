import 'package:flutter/material.dart';

import 'core/constants/app_routes.dart';
import 'core/services/camera_service.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/app_translations.dart';
import 'core/services/language_preferences_service.dart';
import 'features/about/presentation/screens/about_screen.dart';
import 'features/camera/presentation/screens/camera_screen.dart';
import 'features/history/presentation/screens/history_screen.dart';
import 'features/home/presentation/screens/menu_screen.dart';
import 'features/scan/presentation/screens/image_preview_screen.dart';
import 'features/settings/presentation/screens/settings_screen.dart';

class CoconutDiseaseApp extends StatefulWidget {
  const CoconutDiseaseApp({super.key});

  @override
  State<CoconutDiseaseApp> createState() => _CoconutDiseaseAppState();
}

class _CoconutDiseaseAppState extends State<CoconutDiseaseApp> {
  late final Future<void> _cameraLoad;

  @override
  void initState() {
    super.initState();
    _cameraLoad = _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.wait([
      CameraService.loadAvailableCameras(),
      LanguagePreferencesService.load(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _cameraLoad,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(
            theme: AppTheme.light,
            home: const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return ValueListenableBuilder(
          valueListenable: LanguagePreferencesService.current,
          builder: (context, _, _) => MaterialApp(
            title: 'CocoScan',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            home: const MenuScreen(),
            routes: {
              AppRoutes.history: (_) => const HistoryScreen(),
              AppRoutes.about: (_) => const AboutScreen(),
              AppRoutes.settings: (_) => const SettingsScreen(),
            },
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case AppRoutes.camera:
                  return MaterialPageRoute(
                    builder: (_) =>
                        CameraScreen(cameras: CameraService.cameras),
                  );
                case AppRoutes.preview:
                  final imagePath = settings.arguments;
                  if (imagePath is String) {
                    return MaterialPageRoute(
                      builder: (_) => ImagePreviewScreen(imagePath: imagePath),
                    );
                  }
              }
              return MaterialPageRoute(builder: (_) => const MenuScreen());
            },
          ),
        );
      },
    );
  }
}
