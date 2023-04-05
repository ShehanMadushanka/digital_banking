import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    
    let channelName = "cdb_secure_method_channel"
    let rootViewController : FlutterViewController = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: rootViewController as! FlutterBinaryMessenger)
    
    methodChannel.setMethodCallHandler {(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if (call.method == "messedUp") {
            let messed = UIDevice.isAppContainUnAuthorizedApps() ||
                UIDevice.isAppCanEditSystemFiles() ||
                UIDevice.isAppCanOpenUnAuthorizedURL() ||
                UIDevice.isAppContainUnAuthorizedFiles() ||
                UIDevice.isSystemAPIAccessable()
            
            result(messed)
        } else if (call.method == "D995DA23505A798C93DA3E2E7F2F1611BB3F4DF1110612705F60C17DFD2759FF") {
            if let args = call.arguments as? Dictionary<String, Any> {
                if let qrString = args["qrString"] as? String {
                    let lankaQr = LankaQRScanner.getLankaQRData(qrString: qrString)
                    if lankaQr == "ERROR" {
                        result(FlutterError(code: "FAIL", message: "Invalid QR", details: "Invalid QR"))
                    } else {
                        result(lankaQr)
                    }
                }
            } else {
                result(FlutterError(code: "FAIL", message: "Invalid QR", details: "Invalid QR"))
            }
        }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
