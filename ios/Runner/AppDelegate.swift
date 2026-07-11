import Flutter
import UIKit
import Firebase
import flutter_local_notifications
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
     FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
      }
         GeneratedPluginRegistrant.register(with: self)
    if let controller = window?.rootViewController as? FlutterViewController {
      let channel = FlutterMethodChannel(
        name: "app/google_maps",
        binaryMessenger: controller.binaryMessenger
      )
      channel.setMethodCallHandler { call, result in
        if call.method == "setApiKey", let key = call.arguments as? String, !key.isEmpty {
          GMSServices.provideAPIKey(key)
          result(true)
        } else {
          result(FlutterMethodNotImplemented)
        }
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

}
