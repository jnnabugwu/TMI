import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
   
    GeneratedPluginRegistrant.register(with: self)

     GMSServices provideAPIKey:("AIzaSyCs2X3gpmaK2F_1OHWPiu87pS1-hD--PNI")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
