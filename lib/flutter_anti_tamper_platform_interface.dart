import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_anti_tamper_method_channel.dart';

abstract class FlutterAntiTamperPlatform extends PlatformInterface {
  /// Constructs a FlutterAntiTamperPlatform.
  FlutterAntiTamperPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAntiTamperPlatform _instance = MethodChannelFlutterAntiTamper();

  /// The default instance of [FlutterAntiTamperPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAntiTamper].
  static FlutterAntiTamperPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAntiTamperPlatform] when
  /// they register themselves.
  static set instance(FlutterAntiTamperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
