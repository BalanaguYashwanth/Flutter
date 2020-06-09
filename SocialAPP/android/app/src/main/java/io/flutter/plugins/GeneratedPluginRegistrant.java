package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.flutterbeacon.FlutterBeaconPlugin;
import com.pauldemarco.flutter_blue.FlutterBluePlugin;
import io.github.edufolly.flutterbluetoothserial.FlutterBluetoothSerialPlugin;
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FlutterBeaconPlugin.registerWith(registry.registrarFor("com.flutterbeacon.FlutterBeaconPlugin"));
    FlutterBluePlugin.registerWith(registry.registrarFor("com.pauldemarco.flutter_blue.FlutterBluePlugin"));
    FlutterBluetoothSerialPlugin.registerWith(registry.registrarFor("io.github.edufolly.flutterbluetoothserial.FlutterBluetoothSerialPlugin"));
    FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
