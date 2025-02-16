import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_anti_tamper/flutter_anti_tamper.dart';
import 'package:flutter_anti_tamper/flutter_anti_tamper_platform_interface.dart';
import 'package:flutter_anti_tamper/flutter_anti_tamper_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterAntiTamperPlatform
    with MockPlatformInterfaceMixin
    implements FlutterAntiTamperPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterAntiTamperPlatform initialPlatform = FlutterAntiTamperPlatform.instance;

  test('$MethodChannelFlutterAntiTamper is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterAntiTamper>());
  });

  test('getPlatformVersion', () async {
    FlutterAntiTamper flutterAntiTamperPlugin = FlutterAntiTamper();
    MockFlutterAntiTamperPlatform fakePlatform = MockFlutterAntiTamperPlatform();
    FlutterAntiTamperPlatform.instance = fakePlatform;

    expect(await flutterAntiTamperPlugin.getPlatformVersion(), '42');
  });
}
