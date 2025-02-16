# 🔒 flutter_anti_tamper

🚀 **`flutter_anti_tamper`** es un plugin de seguridad para Flutter que detecta y previene manipulaciones en la aplicación. Identifica si el dispositivo está **rooteado**, **tiene Xposed**, **usa Frida** o **está en Jailbreak**, y permite tomar medidas como cerrar la app automáticamente.

---

## 📌 Características principales

✅ **Detección de Root en Android** (`isRooted`)
✅ **Detección de Xposed Framework en Android** (`isXposedDetected`)
✅ **Detección de Frida en Android e iOS** (`isFridaDetected`)
✅ **Detección de Jailbreak en iOS** (`isJailbroken`)
✅ **Cierre automático de la app si el dispositivo está comprometido**
✅ **Compatible con Android e iOS**

---

## 📦 Instalación

Agrega `flutter_anti_tamper` a tu archivo `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_anti_tamper:
```

Luego ejecuta:

```sh
flutter pub get
```

---

## ⚡ Uso

### 📌 Verificar seguridad del dispositivo

```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_anti_tamper/flutter_anti_tamper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
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

    setState(() {
      if (rooted || xposed || frida || jailbroken) {
        securityStatus = "⚠️ Dispositivo NO seguro. Cerrando en 3 segundos...";
        Future.delayed(Duration(seconds: 3), () {
          closeApp();
        });
      } else {
        securityStatus = "✅ Dispositivo seguro";
      }
    });
  }

  void closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Flutter Anti-Tamper")),
        body: Center(child: Text(securityStatus, style: const TextStyle(fontSize: 20))),
      ),
    );
  }
}
```

---

## 🎯 Métodos disponibles

| Método                 | Descripción                                     | Plataforma   |
|------------------------|---------------------------------|-------------|
| `isRooted()`          | Detecta si el dispositivo tiene acceso Root  | Android     |
| `isXposedDetected()`  | Detecta si Xposed Framework está instalado  | Android     |
| `isFridaDetected()`   | Detecta si Frida está activo en el dispositivo  | Android/iOS |
| `isJailbroken()`      | Detecta si el dispositivo tiene Jailbreak  | iOS         |

---

## ⚙️ Configuración adicional

### **Android**
Si quieres mejorar la detección de Frida y Xposed en Android, asegúrate de que **ProGuard** no bloquee la detección en `android/app/proguard-rules.pro`:

```proguard
-keep class de.robv.android.xposed.** { *; }
```

---

## ❗ Consideraciones

🔹 **Este plugin es una capa adicional de seguridad, pero no sustituye buenas prácticas de desarrollo seguro.**  
🔹 **Siempre complementa esta detección con otras medidas como encriptación y monitoreo en backend.**

---

## 📝 Licencia

Este proyecto está bajo la licencia **MIT**.

---

## ✨ Contribuciones

👨‍💻 ¡Las contribuciones son bienvenidas! Si quieres mejorar este plugin, haz un **Pull Request** o abre un **Issue** en el repositorio.

📢 **Síguenos en [GitHub](https://github.com/AndresCarden/flutter_anti_tamper.git)** y ⭐ ¡Dale una estrella si te ayudó!

---

## 📬 Contacto

Si tienes dudas o sugerencias, puedes escribirme a **[cardenasandres5@gmail.com](mailto:cardenasandres5@gmail.com)**.

---

