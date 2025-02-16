import Flutter
import UIKit
import MachO // Importamos Mach-O para acceder a _dyld_get_image_name

public class FlutterAntiTamperPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_anti_tamper", binaryMessenger: registrar.messenger())
        let instance = FlutterAntiTamperPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        print("🔥 FlutterAntiTamper: Plugin registered")
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print("📢 FlutterAntiTamper: Received Method Call \(call.method)")
        switch call.method {
            case "isJailbroken":
                let jailbroken = self.isJailbroken()
                print("🔍 Jailbreak Detected: \(jailbroken)")
                result(jailbroken)
            case "isFridaDetected":
                let fridaDetected = self.isFridaDetected()
                print("⚠️ Frida Detected: \(fridaDetected)")
                result(fridaDetected)
            default:
                result(FlutterMethodNotImplemented)
        }
    }

    private func isJailbroken() -> Bool {
        let paths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt"
        ]
        for path in paths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }

    private func isFridaDetected() -> Bool {
        let suspiciousLibraries = [
            "FridaGadget",
            "frida",
            "libfrida"
        ]

        for i in 0..<_dyld_image_count() {
            if let imageName = _dyld_get_image_name(i) {
                let library = String(cString: imageName)
                if suspiciousLibraries.contains(where: library.contains) {
                    print("⚠️ Frida Library Found: \(library)")
                    return true
                }
            }
        }
        return false
    }
}
