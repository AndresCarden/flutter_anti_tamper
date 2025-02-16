import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_anti_tamper_example/flutter_anti_tamper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String securityStatus = "Checking...";

  @override
  void initState() {
    super.initState();
    checkSecurity();
  }

  Future<void> checkSecurity() async {
    bool rooted = await FlutterAntiTamper.isRooted();
    bool xposed = await FlutterAntiTamper.isXposedDetected();
    bool frida = await FlutterAntiTamper.isFridaDetected();
    bool jailbroken = await FlutterAntiTamper.isJailbroken();

    // Imprimir los valores en la consola
    log("📢 Rooted: $rooted");
    log("📢 Xposed Detected: $xposed");
    log("📢 Frida Detected: $frida");
    log("📢 Jailbroken: $jailbroken");

    setState(() {
      if (rooted || xposed || frida || jailbroken) {
        securityStatus = "⚠️ Dispositivo NO seguro. Cerrando en 3 segundos...";
        Future.delayed(const Duration(seconds: 3), () {
          closeApp();
        });
      } else {
        securityStatus = "✅ Dispositivo seguro";
      }
    });
  }

  void closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop(); // Cierra la app en Android
    } else if (Platform.isIOS) {
      exit(0); // Cierra la app en iOS
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Flutter Anti-Tamper")),
        body: Center(child: Center(child: Text(securityStatus, style: const TextStyle(fontSize: 20)))),
      ),
    );
  }
}
