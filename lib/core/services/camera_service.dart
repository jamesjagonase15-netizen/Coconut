import 'package:camera/camera.dart';

/// Owns device-camera discovery so app startup is kept out of the UI layer.
abstract final class CameraService {
  static List<CameraDescription> _cameras = const [];

  static List<CameraDescription> get cameras => _cameras;

  static Future<void> loadAvailableCameras() async {
    try {
      _cameras = await availableCameras();
    } catch (_) {
      _cameras = const [];
    }
  }
}
