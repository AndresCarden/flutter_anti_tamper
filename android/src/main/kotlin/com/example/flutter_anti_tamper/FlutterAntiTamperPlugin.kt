package com.example.flutter_anti_tamper

import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File

class FlutterAntiTamperPlugin: FlutterPlugin, MethodChannel.MethodCallHandler {

  private lateinit var channel: MethodChannel

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "flutter_anti_tamper")
    channel.setMethodCallHandler(this)
    Log.d("FlutterAntiTamper", "🔥 Plugin Attached")
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    Log.d("FlutterAntiTamper", "📢 Received Method Call: ${call.method}")

    when (call.method) {
      "isRooted" -> {
        val rooted = isDeviceRooted()
        Log.d("FlutterAntiTamper", "🔍 isRooted() -> $rooted")
        result.success(rooted)
      }
      "isXposedDetected" -> {
        val xposed = isXposedInstalled()
        Log.d("FlutterAntiTamper", "🔍 isXposedDetected() -> $xposed")
        result.success(xposed)
      }
      "isFridaDetected" -> {
        val frida = isFridaDetected()
        Log.d("FlutterAntiTamper", "🔍 isFridaDetected() -> $frida")
        result.success(frida)
      }
      else -> result.notImplemented()
    }
  }

  private fun isDeviceRooted(): Boolean {
    val rootFiles = arrayOf(
      "/system/app/Superuser.apk",
      "/sbin/su",
      "/system/bin/su",
      "/system/xbin/su",
      "/data/local/xbin/su",
      "/data/local/bin/su",
      "/system/sd/xbin/su",
      "/system/bin/failsafe/su"
    )
    val result = rootFiles.any { File(it).exists() }
    Log.d("FlutterAntiTamper", "✅ Root check result: $result")
    return result
  }

  private fun isXposedInstalled(): Boolean {
    return try {
      val xposedClass = Class.forName("de.robv.android.xposed.XposedBridge")
      Log.d("FlutterAntiTamper", "⚠️ Xposed detected!")
      true
    } catch (e: ClassNotFoundException) {
      Log.d("FlutterAntiTamper", "✅ Xposed not detected")
      false
    }
  }

  private fun isFridaDetected(): Boolean {
    return try {
      val mapsFile = File("/proc/self/maps")
      val result = mapsFile.readText().contains("frida")
      Log.d("FlutterAntiTamper", "🔍 Frida Detected: $result")
      result
    } catch (e: Exception) {
      Log.d("FlutterAntiTamper", "❌ Error checking Frida: ${e.message}")
      false
    }
  }


  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
