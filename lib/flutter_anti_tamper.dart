
import 'flutter_anti_tamper_platform_interface.dart';

class FlutterAntiTamper {
  Future<String?> getPlatformVersion() {
    return FlutterAntiTamperPlatform.instance.getPlatformVersion();
  }
}
