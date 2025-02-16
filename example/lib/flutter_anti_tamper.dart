import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';

class FlutterAntiTamper {
  static const MethodChannel _channel = MethodChannel('flutter_anti_tamper');

  static Future<bool> isRooted() async {
    try {
      final bool? result = await _channel.invokeMethod<bool>('isRooted');
      log("📢 isRooted() -> $result");
      return result ?? false;
    } catch (e) {
      log("❌ Error en isRooted(): $e");
      return false;
    }
  }

  static Future<bool> isXposedDetected() async {
    try {
      final bool? result = await _channel.invokeMethod<bool>('isXposedDetected');
      log("📢 isXposedDetected() -> $result");
      return result ?? false;
    } catch (e) {
      log("❌ Error en isXposedDetected(): $e");
      return false;
    }
  }

  static Future<bool> isFridaDetected() async {
    try {
      final bool? result = await _channel.invokeMethod<bool>('isFridaDetected');
      log("📢 isFridaDetected() -> $result");
      return result ?? false;
    } catch (e) {
      log("❌ Error en isFridaDetected(): $e");
      return false;
    }
  }

  static Future<bool> isJailbroken() async {
    if (!Platform.isIOS) {
      log("📢 isJailbroken() -> No es iOS, omitiendo chequeo.");
      return false;
    }

    try {
      final bool? result = await _channel.invokeMethod<bool>('isJailbroken');
      log("📢 isJailbroken() -> $result");
      return result ?? false;
    } catch (e) {
      log("❌ Error en isJailbroken(): $e");
      return false;
    }
  }
}